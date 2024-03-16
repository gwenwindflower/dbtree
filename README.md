# 🌲🌳 dbtree 🚃🌉

> This project is forked from the great [Simon Willison](https://github.com/simonw)'s git scraping project [sf-tree-history](https://github.com/simonw/sf-tree-history). The original project is a demonstration of how to use GitHub Actions to run a Python script that scrapes data from a website and commits the data to the repository, using Simon's `csv-diff` project to generate human readable commits on changes to the data. Git itself then acts as a versioned database for the data.

This project takes the original and builds a complete data stack on top of it. It uses a combination of `dbt`, `DuckDB` and `Evidence` to model and visualize the data.
