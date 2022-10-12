FROM python:3.6

ENV BASE_API_ENV="test pipenv run pytest"

RUN mkdir -p /opt/app
COPY base-test-api/ /opt/app/
WORKDIR /opt/app
RUN pip install pipenv
RUN pipenv install

EXPOSE 8080
ENTRYPOINT ["pipenv", "run", "python", "start.py", "runserver"] 