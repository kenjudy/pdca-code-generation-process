// @ts-nocheck
'use strict';

/**
 * Compute commit velocity and trend from an array of ISO 8601 date strings.
 * Input order does not matter — dates are sorted internally.
 * @param {string[]} dates
 * @returns {{ commits_per_day: number, trend: string }}
 */
function computeVelocity(dates) {
  if (dates.length < 2) return { commits_per_day: dates.length, trend: 'stable' };

  const ms = dates.map(d => new Date(d).getTime()).sort((a, b) => a - b);
  const spanDays = (ms[ms.length - 1] - ms[0]) / 86400000 || 1;
  const commits_per_day = dates.length / spanDays;

  // Split commits at time midpoint; compare first-half vs second-half rate
  const midMs = (ms[0] + ms[ms.length - 1]) / 2;
  const firstHalf = ms.filter(t => t <= midMs);
  const secondHalf = ms.filter(t => t > midMs);
  const halfSpan = spanDays / 2 || 1;
  const firstRate = firstHalf.length / halfSpan;
  const secondRate = secondHalf.length / halfSpan;

  let trend = 'stable';
  if (secondRate > firstRate * 1.25) trend = 'accelerating';
  else if (secondRate < firstRate * 0.75) trend = 'decelerating';

  return { commits_per_day, trend };
}

/**
 * Compute statistical distribution of a numeric array.
 * @param {number[]} sizes
 * @param {number[]} timestamps - epoch ms values, same length as sizes, time-ordered oldest first
 * @returns {{ p50: number, p90: number, p95: number, mean: number, stddev: number, trend: string, isOutlier: (v: number) => boolean }}
 */
function computeStatistics(sizes, timestamps) {
  if (sizes.length === 0) {
    return { p50: 0, p90: 0, p95: 0, mean: 0, stddev: 0, trend: 'stable', isOutlier: () => false };
  }

  // Percentile (linear interpolation)
  const sorted = [...sizes].sort((a, b) => a - b);
  /** @param {number} p - 0..1 */
  function quantile(p) {
    if (sorted.length === 1) return sorted[0];
    const idx = p * (sorted.length - 1);
    const lo = Math.floor(idx);
    const hi = Math.ceil(idx);
    return sorted[lo] + (sorted[hi] - sorted[lo]) * (idx - lo);
  }

  const mean = sizes.reduce((s, v) => s + v, 0) / sizes.length;
  const variance = sizes.reduce((s, v) => s + (v - mean) ** 2, 0) / sizes.length;
  const stddev = Math.sqrt(variance);

  // Trend: linear regression slope of size over time index
  const n = sizes.length;
  let trend = 'stable';
  if (n >= 2) {
    // Normalize timestamps to [0..1] to avoid floating-point magnitude issues
    const t0 = timestamps[0];
    const tRange = (timestamps[n - 1] - t0) || 1;
    const xs = timestamps.map(t => (t - t0) / tRange);
    const xMean = xs.reduce((s, v) => s + v, 0) / n;
    const yMean = mean;
    const num = xs.reduce((s, x, i) => s + (x - xMean) * (sizes[i] - yMean), 0);
    const den = xs.reduce((s, x) => s + (x - xMean) ** 2, 0);
    const slope = den === 0 ? 0 : num / den;
    // Threshold: slope relative to mean — ignore noise below 5% of mean per unit
    const threshold = yMean * 0.05;
    if (slope > threshold) trend = 'growing';
    else if (slope < -threshold) trend = 'shrinking';
  }

  const cutoff = mean + 2 * stddev;
  return {
    p50: quantile(0.5),
    p90: quantile(0.9),
    p95: quantile(0.95),
    mean,
    stddev,
    trend,
    isOutlier: (v) => stddev > 0 && v > cutoff
  };
}

module.exports = { computeVelocity, computeStatistics };
