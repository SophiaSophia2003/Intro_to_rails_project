class AboutesController < ApplicationController

  def index
    @about_title = "About Us"
    @about_content = " In this project, we used google API as a data source. Here is the description of datasets we are using in this project.

    Books {

     id: integer,
     title: string,
     published_date: string,
     description: text,
     isbn: string,
     language: string,
     image_small_thumbnail: string,
     image_thumbnail: string,
     preview_link: string,
     author_id: integer

     }

     Authors {

      id: integer,
      name: string,
      birth_date: date

     }

     Categories {

      id: integer,
      name: string

     }

     Publishers {

       id: integer,
       name: string

     }

     Reviews {

      id: integer,
      rating: integer,
      comment: text,
      review_date: datetime

     }."
  end
end
