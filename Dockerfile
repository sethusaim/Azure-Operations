FROM python:3.7-slim-buster

WORKDIR /app

COPY app.py /app

COPY req.txt /app

RUN pip install -r req.txt

CMD ["python3", "app.py"]