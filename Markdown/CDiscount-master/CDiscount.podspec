Pod::Spec.new do |s|
  s.name         = "CDiscount"
  s.version      = "2.2.1"
  s.summary      = "DISCOUNT is a implementation of John Gruber's Markdown markup language."
  s.license      = { :type => 'BSD', :file => 'COPYRIGHT' }
  s.description  = <<-DESC
                   DISCOUNT is free software written by David Parsons <orc@pell.portland.or.us>;
                   it is released under a BSD-style license that allows you to do
                   as you wish with it as long as you don't attempt to claim it as
                   your own work.
                   DESC

  s.homepage     = "https://github.com/Orc/discount"
  s.social_media_url = "https://github.com/Orc/discount"
  s.authors      = { "David Parsons" => "orc@pell.portland.or.us" }
  
  s.source       = { :git => "https://github.com/Orc/discount.git", 
                     :tag => "v#{s.version}" }

  s.requires_arc = false

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.prepare_command = <<-CMD
                        ./configure.sh --enable-dl-tag --enable-pandoc-header --enable-superscript
                        cc mktags.c -o mktags
                        ./mktags > blocktags
                   CMD

  s.source_files = "*.h", "*.c", "blocktags"
  s.public_header_files = "mkdio.h"

  s.exclude_files = "amalloc.c",
                    "theme.c",
                    "mkd2html.c",
                    "main.c",
                    "pgm_options.c",
                    "pgm_options.h",
                    "makepage.c",
                    "mktags.c"
                    
  s.compiler_flags = "-DVERSION=\\\"#{s.version}\\\""

end
