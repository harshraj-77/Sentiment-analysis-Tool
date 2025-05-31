# Use official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y     build-essential     gcc     libffi-dev     libssl-dev     libxml2-dev     libxslt1-dev     zlib1g-dev     libjpeg-dev     && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy rest of the app
COPY . .

# Expose the port
EXPOSE 8000

# Start the app with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]