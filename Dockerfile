FROM arizephoenix/phoenix:latest

# Switch to root to make modifications
USER root

# Set working directory
WORKDIR /app

# Copy our custom entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose the Heroku-assigned port
# Note: Heroku will set PORT environment variable at runtime
EXPOSE $PORT

# Set Python to not buffer stdout and stderr to get logs in real time
ENV PYTHONUNBUFFERED=1

# Disable gRPC port for Heroku (since Heroku only exposes one port)
ENV PHOENIX_OTLP_GRPC_ENABLED=false

# Set up environment for Heroku
ENV PHOENIX_HOST=0.0.0.0

# Run as non-root user for security
USER 1000

# Use our custom entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]

# The default command to run when the container starts
CMD ["python", "-m", "phoenix.server.main", "serve"]