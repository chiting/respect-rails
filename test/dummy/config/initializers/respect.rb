Respect::Rails.setup do |config|
  config.app_documentation <<-EOS.strip_heredoc
    A great dummy app.

    This is a great dummy app we love to torture.
  EOS

  config.helpers Respect::ApplicationMacros
end
