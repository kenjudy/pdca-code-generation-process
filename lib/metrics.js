// @ts-nocheck
'use strict';

const { CONFIG } = require('./config');

/**
 * Check if a filename matches test file patterns.
 * Defined here (not lib/git.js) so GitHub Actions workflows can require('./lib/metrics')
 * without pulling in child_process-dependent git functions.
 * @param {string} filename
 * @returns {boolean}
 */
function isTestFile(filename) {
  return CONFIG.TEST_FILE_PATTERNS.some(pattern => pattern.test(filename));
}

/** @type {RegExp} */
const CONVENTIONAL_COMMIT_RE = /^(feat|fix|refactor|test|chore|docs|perf|ci|build|revert)(\(.+\))?:/i;

/**
 * Score a single commit message for quality.
 * Quality = conventional commit format OR word count >= MESSAGE_QUALITY_MIN_WORDS.
 * @param {string} message
 * @returns {boolean}
 */
function scoreMessageQuality(message) {
  if (!message) return false;
  if (CONVENTIONAL_COMMIT_RE.test(message)) return true;
  return message.split(/\s+/).filter(Boolean).length >= CONFIG.MESSAGE_QUALITY_MIN_WORDS;
}

/**
 * Classify a repo into a DORA team archetype based on summary metrics.
 * Evaluated in priority order: harmonious-high-achiever → legacy-bottleneck → foundational-challenges → mixed-signals
 * @param {{ large_commits_pct: string, sprawling_commits_pct: string, test_coverage_rate: string, uncovered_prod_rate: string, message_quality_pct: string }} summary
 * @returns {string}
 */
function classifyDoraArchetype(summary) {
  const large = parseFloat(summary.large_commits_pct);
  const sprawling = parseFloat(summary.sprawling_commits_pct);
  const testCoverage = parseFloat(summary.test_coverage_rate);
  const uncoveredProd = parseFloat(summary.uncovered_prod_rate);
  const msgQuality = parseFloat(summary.message_quality_pct);

  if (large < 20 && sprawling < 10 && testCoverage > 50 && uncoveredProd < 10 && msgQuality > 60) return 'harmonious-high-achiever';
  if (sprawling > 25 && large > 30) return 'legacy-bottleneck';
  if (large > 40 || uncoveredProd > 20) return 'foundational-challenges';
  return 'mixed-signals';
}

/**
 * Generate insights based on metrics
 * @param {{ large_commits_pct: string, sprawling_commits_pct: string, test_coverage_rate: string, test_isolation_rate: string, uncovered_prod_rate: string, avg_lines_changed: string }} summary
 * @param {Array<object>} metrics
 * @returns {{ insights: string[], warnings: string[], recommendations: string[] }}
 */
function generateInsights(summary, metrics) {
  const insights = [];
  const warnings = [];
  const recommendations = [];

  const largePct = parseFloat(summary.large_commits_pct);
  const sprawlingPct = parseFloat(summary.sprawling_commits_pct);
  const testCoveragePct = parseFloat(summary.test_coverage_rate);
  const testIsolationPct = parseFloat(summary.test_isolation_rate);
  const uncoveredProdPct = parseFloat(summary.uncovered_prod_rate);
  const avgLines = parseFloat(summary.avg_lines_changed);

  if (largePct > 40) {
    warnings.push(`🚨 Very high large commit rate (${largePct}%) - Strong AI drift indicators`);
    recommendations.push('Consider breaking AI-generated code into smaller, focused commits');
  } else if (largePct > 20) {
    warnings.push(`⚠️ High large commit rate (${largePct}%) - Monitor AI tool usage patterns`);
  } else {
    insights.push(`✅ Healthy large commit rate (${largePct}%)`);
  }

  if (sprawlingPct > 25) {
    warnings.push(`🚨 Very high sprawling commit rate (${sprawlingPct}%) - Possible shotgun surgery`);
    recommendations.push('Review if AI suggestions are causing scattered changes across unrelated files');
  } else if (sprawlingPct > 10) {
    warnings.push(`⚠️ High sprawling commit rate (${sprawlingPct}%) - Watch for scope creep`);
  } else {
    insights.push(`✅ Good sprawling commit control (${sprawlingPct}%)`);
  }

  if (uncoveredProdPct > 20) {
    warnings.push(`🚨 High rate of uncovered production commits (${uncoveredProdPct}%) - Large prod commits with no tests`);
    recommendations.push('Write tests before accepting AI-generated production code');
  } else if (uncoveredProdPct >= 10) {
    warnings.push(`⚠️ Elevated uncovered production commits (${uncoveredProdPct}%) - Monitor test discipline`);
  }

  if (testCoveragePct > 50) {
    insights.push(`✅ Strong test coverage discipline (${testCoveragePct}%)`);
  } else if (testCoveragePct < 30) {
    warnings.push(`⚠️ Low test coverage rate (${testCoveragePct}%) - AI tools may be bypassing TDD`);
    recommendations.push('Ensure test coverage when accepting AI-generated code');
  }

  if (testIsolationPct > 10) {
    insights.push(`✅ Healthy rate of test-only commits (${testIsolationPct}%) - TDD red-phase or test improvement commits visible`);
  }

  if (avgLines > 1000) {
    warnings.push(`🚨 Very high average lines per commit (${avgLines}) - Extreme batch coding`);
    recommendations.push('Implement strict commit size limits when using AI tools');
  } else if (avgLines > 500) {
    warnings.push(`⚠️ High average lines per commit (${avgLines}) - Monitor AI batch acceptance`);
  }

  const possibleAICommits = metrics.filter(m =>
    m.large_commit && m.total_additions > m.total_deletions * 3
  ).length;

  if (possibleAICommits > metrics.length * 0.3) {
    warnings.push(`🤖 High proportion of addition-heavy large commits (${possibleAICommits}/${metrics.length}) - Possible AI batch acceptance`);
  }

  return { insights, warnings, recommendations };
}

module.exports = { isTestFile, scoreMessageQuality, classifyDoraArchetype, generateInsights };
