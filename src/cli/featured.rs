use std::ops::Deref;

use crate::cli::install::{self, InstallOptions};

const FEATURED_TAPES_URL: &str = "https://github.com/futurekismo-oss/featured-tapes";

pub fn run(source: String,  name: Option<String>, no_hooks: bool, yes: bool, force: bool) -> Result<(), anyhow::Error> {
   
    let name = name.unwrap_or(source.deref().to_string());
    
    let install_options = InstallOptions {
        source: FEATURED_TAPES_URL.to_string(),
        name: Some(name),
        dir: Some(source),
        no_hooks,
        yes,
        force,
        full_clone: false,
        quiet: false,
        branch: None,
    };

    install::run(install_options)?;
    

    Ok(())
}

