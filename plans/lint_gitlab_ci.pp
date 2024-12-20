
plan ctlrepo::lint_gitlab_ci (
  TargetSpec           $targets     = 'localhost',
  Stdlib::Absolutepath $file        = "${system::env('PWD')}/.gitlab-ci.yml",
  Stdlib::Host         $server      = '192.168.1.15',
  Stdlib::HTTPUrl      $ci_lint_api = "https://${server}/api/v4/ci/lint",
  Sensitive[String[1]] $token       = Sensitive(system::env('GITLAB_API_TOKEN')),
){
  return run_task('ctlrepo::lint_gitlab_ci', get_targets($targets), "CI Lint: ${file}", {
    'gitlab_ci_lint_uri'       => $ci_lint_api,
    'gitlab_private_api_token' => "${token.unwrap}",
    'repo_paths' => [$file.dirname],
  })
}
