---
title: Курсы
summary: My courses
type: landing
build:
  render: never
  list: never

cascade:
  type: docs
  build:
    render: never
    list: never
  params:
    show_breadcrumb: true

sections:
  - block: collection
    id: courses
    content:
      title: Courses
      filters:
        tag: Course
        kinds:
          - section
    design:
      view: article-grid
      show_read_time: false
      show_date: false
      show_read_more: false
      columns: 1
---
