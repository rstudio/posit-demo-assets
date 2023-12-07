# Posit Demo Assets

This repo contains demo assets to be used on the Posit Test Drive environment.

## What is Posit Test Drive

Posit Test Drive is a limited demo environment hosted by Posit to help you learn more and try out the various features.

## Video series

Do you prefer watching videos over reading? Check out the [end-to-end data science workflows video series](https://www.youtube.com/watch?v=L6lh2u5pFhc&list=PL9HYL-VRX0oRsUB5AgNMQuKuHPpNDLBVt&pp=iAQB) for inspiration for what Posit Team enables your team to accomplish!

## Getting Started

Here you will find three products:

- **Posit Workbench** is your development environment for creating R and Python code and running large computationally intensive jobs in a secure and scaleable environment.
- **Posit Connect** is a publishing platform for hosting the work your team creates in R and Python.
- **Posit Package Manager** is a repository management server to organize and centralize R and Python packages across your organization.

## Milestones to Success
It can be very daunting learning a new system. Here are some useful resources to explore as you get familiar with the Posit products. 

### First Day
Orient yourself to the products and learning resources.

#### Orientation

- How to log in
- Explore the UI 
- [Explore the User Guides](#user-guides)
- [New to R/Python?](#new-to-rpython)

###### User Guides

- [Posit Workbench User Guide](https://docs.posit.co/ide/server-pro/user/)
- [Posit Connect User Guide](https://docs.posit.co/connect/user/)
- [Posit Package Manager User Guide](https://docs.posit.co/rspm/user/)

###### New to R/Python?

- [R in Posit Workbench](https://docs.posit.co/ide/server-pro/user/posit-workbench/guide/r.html)
- [Python in Posit Workbench](https://docs.posit.co/ide/server-pro/user/posit-workbench/guide/python.html)

### First Week

Learn how to use certain product features and deploy content to share with others. 

#### Posit Workbench 

- [Launch a Workbench Job](https://docs.posit.co/ide/server-pro/user/rstudio-pro/guide/workbench-jobs.html)
- [Open a project](#how-do-i-open-a-project)
- [Publish to Posit Connect using push button publishing](https://docs.posit.co/connect/user/publishing/#publishing-general)
- [Publish to Posit Connect using rsconnect or rsconnect-python programmatic publishing](https://docs.posit.co/connect/user/publishing-cli/)
- [Learn best practises for environment management in R](https://docs.posit.co/ide/server-pro/user/posit-workbench/guide/r.html#renv)
- [Learn best practises for environment management in python](https://docs.posit.co/ide/server-pro/user/posit-workbench/guide/python.html#virtual-environments)
  
#### Posit Connect 

- [Understand the differences between an admin, viewer, and publisher roles](https://docs.posit.co/connect/admin/user-management/index.html#user-roles) 
- [Generate an API key](https://docs.posit.co/connect/user/api-keys/)
- [Share a piece of content with other users](https://docs.posit.co/connect/cookbook/sharing/)
- [Edit the runtime settings](https://docs.posit.co/connect/user/content-settings/index.html#content-runtime) 
- [Schedule a report](https://docs.posit.co/connect/user/content-settings/#content-schedule)
- [Customize a contents URL](https://docs.posit.co/connect/user/content-settings/#custom-url)
- [Explore the logs of different content types](https://docs.posit.co/connect/user/content-settings/#content-logs) 
- [Add environment variables to content](https://docs.posit.co/connect/user/content-settings/#content-vars) 

#### Posit Package Manager 

- [Obtain a repository URL](https://docs.posit.co/rspm/user/get-repo-url/#get-repo-url)
- [Install a package from a date-based snapshot](https://docs.posit.co/rspm/user/get-repo-url/#ui-frozen-urls)
- [Identify the system dependencies of a package](https://docs.posit.co/rspm/admin/appendix/system-dependency-detection/#system-dependency-detection)

### How do I open a project?
#### R content

There are two ways to open an R project. 

##### Option 1:

1. Find the Files tab on the bottom left of the screen 
2. Navigate to the project folder you want to work in.
3. Launch the project

##### Option 2: 
1. Navigate to the project folder you want to work in.
2. Restore the needed packages into the renv environment.
````
    setwd("./R/shiny-penguins/")
    renv::restore()
````

#### Python content

1. Create a virtual environment in the folder you want to work in.
2. Restore the needed packages into the virtual environment.
````
    cd python-examples/dash-app
    python3 -m venv .venv
    source .venv/bin/activate
    python3 -m pip install -U pip setuptools wheel
    python3 -m pip install -r requirements.txt
````

## Running into issues?

Reach out to your Posit account executive who can answer your questions or direct you to the right resources as you evaluate Posit. If you aren't sure who your account executive is email [sales@posit.co](mailto:sales@posit.co){.email} and ask to be introduced.

Get technical help! Email-based Posit support is also available. Learn how to submit support tickets: [here](https://support.posit.co/hc/en-us/articles/360004788294-How-do-I-submit-a-Support-ticket-#)

## Want to add an example?

Awesome!

For R based projects the requirements are:

1. Clone and branch this project.
2. Use [renv](https://rstudio.github.io/renv/articles/renv.html) to record the r package versions used
3. Create a [`manifest.json` file](https://docs.posit.co/connect/user/git-backed/#creating-a-manifest-file-from-r) to support git-backed publishing
4. Submit the Pull Request (PR) to have your changes added to this repository.

For Python based projects the requirements are:

1. Clone and branch this project.
2. Create a `venv` to isolatle enviornments and generate a `requirements.txt` file so that only the minimum packages needed to support your project are included. Read [this](https://docs.posit.co/connect/admin/python/package-management/index.html) for more on Python package management.
3. Create a [`manifest.json` file](https://docs.posit.co/connect/user/publishing-cli-notebook/index.html#creating-a-manifest-for-future-deployment) to support git-backed publishing
4. Submit the Pull Request (PR) to have your changes added to this repository.
