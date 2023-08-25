# Posit Demo Assets

Welcome to your Posit Team evaluation environment!

## Getting Started

Here you will find three products:

-   **Posit Workbench** is your development environment for creating R and Python code and running large computationally intensive jobs in a secure and scaleable environment.
  -   User Guide: [Posit Workbench User Guide](https://docs.posit.co/ide/server-pro/user/)

-   **Posit Connect** is a publishing platform for hosting the work your team creates in R and Python.
  -   User Guide: [Posit Connect Documentation - Posit Connect User Guide](https://docs.posit.co/connect/user/)

-   **Posit Package Manager** is a repository management server to organize and centralize R and Python packages across your organization.
  -   User Guide: [User Guide - Posit Package Manager](https://docs.posit.co/rspm/user/)

### New to R or Python?

Check out our getting started resources: 

-   R: [R in Posit Workbench](https://docs.posit.co/ide/server-pro/user/posit-workbench/guide/r.html)
-   Python: [Python in Posit Workbench](https://docs.posit.co/ide/server-pro/user/posit-workbench/guide/python.html)

If you have a question about a particular code issue, we'd recommend starting by creating a reproducible example (or reprex). This will often help as the process of creating an example will help you think about your problem in a way that helps solve it, and will help to capture the problem in a way that will allow others to understand the issue clearly.

Posit Community is our supported site for getting, giving and accepting data science, R and Python help. For open-source questions, this should be your first place to research and ask questions. Check out community open-source help: [here](https://community.rstudio.com/)

### Running into issues?

Reach out to your Posit point person! Your Customer Success rep is your point person for getting the most value out of your existing product subscriptions, and guiding you to solutions with all things data science, R, Python and Posit. If you aren't sure who your Customer Success rep is email [sales\@posit.co](mailto:sales@posit.co){.email} and ask to be introduced.

Get technical help! Premium support is email-based access to Posit Support Engineers during the workday and work week. Learn how to submit support tickets: [here](https://support.posit.co/hc/en-us/articles/360004788294-How-do-I-submit-a-Support-ticket-#)

## What are the things you can do with Posit Team? 

### Video tutorials 

Check out the [end-to-end data science workflows video series](https://www.youtube.com/watch?v=L6lh2u5pFhc&list=PL9HYL-VRX0oRsUB5AgNMQuKuHPpNDLBVt&pp=iAQB) for inspiration!

## Exploring this project

We've created a handful of examples to explore to see what is possible with Posit Team. Follow the suggested curriculum below for a more guided order to exploring the project, or feel free to follow what stands out to you. 

### First hour

Goal: Orient yourself to the interfaces to the different products and resources for learning.

Quick orientation

-   how to login
-   UI navigation
-   UI cheat sheets

Further resources

-   user resources / user guides
-   resources for learning R / Python
-   general Posit resources for when users run into issues, IE how to reach out to the CS, file a Support ticket

### First day

Goal: Learn how to use the different features and do basic deployments.

Workbench

-   collaborative coding and project sharing
-   launching jobs
-   push button publishing
-   rsconnect and rsconnect-python programmatic publishing
-   integration with version control
-   environment management best practices

Connect

-   deployed content examples (Connect quick start examples?)
-   runtime settings
-   scheduling content
-   generating an API key
-   access settings
-   vanity URL's
-   logs
-   environment variables
-   integration with version control

Package Manager

-   downloading packages
-   snapshots
-   system dependencies
-   integration with version control

### First week

Goal: Explore advanced workflows

how to share and use internal packages

-   building a package using workbench
-   deploying that package to package manager using the CLI
-   setting the repository being used in workbench

automating redundant reports and jobs / delivering scheduled reports through email

-   email reports with blastula
-   scheduling
-   parameterized reports

answering questions in real-time

-   interactive application
-   use session user details to dynamically filter content

creating a summary page for stakeholders

-   connectwidgets
-   dashboard
-   view usage data about apps / server using connectapi

sharing data with colleagues (something about pins?) - ETL Automation and reading data from datasources

-   write data to a pin
-   read data from a pin
-   deploy a report to Connect to automate updates to a pin
-   deploy an app to Connect to read from that pin for live updates
-   Load data from from external data source
-   Tidy the data
-   Save the data to a pin
-   Show connections pane
-   Rmarkdown document
-   Use a prexising connection (set up by admin) to load a dataset
-   Create some plots
-   special considerations for PI/PII data

optimize built content for peak performance

-   shinyloadtest
-   profvis
-   runtime settings

how to use our products for Machine Learning

-   Rmarkdown document
-   Workbench job
-   execute a long running job such as training a model
-   demonstrate how parallelization works on Workbench and Connect
-   expose trained model as an API end point
-   demonstrate bilingual teams with R and Python code pieces
-   Pharma machine learning models: <https://posit.co/blog/pharmaceutical-machine-learning-with-tidymodels-and-posit-connect/>

## Want to add an example?

Awesome!

For R based projects the requirements are:

1.  Clone and branch this project.
2.  Use [renv](https://rstudio.github.io/renv/articles/renv.html) so that the package versions are recorded
3.  Create the [`manifest.json` file](https://docs.posit.co/connect/user/git-backed/#creating-a-manifest-file-from-r) to support git-backed publishing
4.  Submit the Pull Request (PR) to have your changes added to this repository.

For Python based projects the requirements are:

1.  Clone and branch this project.
2.  Record the package versions to a `requirements.txt` file. Working inside a `venv` will make it so that only the minimum packages needed to support your project are included. Read [this](https://docs.posit.co/connect/admin/python/package-management/index.html) for more on Python package management.
3.  Create the [`manifest.json` file](https://docs.posit.co/connect/user/publishing-cli-notebook/index.html#creating-a-manifest-for-future-deployment) to support git-backed publishing
4.  Submit the Pull Request (PR) to have your changes added to this repository.
