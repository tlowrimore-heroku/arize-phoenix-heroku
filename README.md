# Arize Phoenix on Heroku

Deploy [Arize Phoenix](https://github.com/Arize-ai/phoenix) LLM observability platform on Heroku with one click.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://dashboard.heroku.com/new?template=https://github.com/dsouza-anush/arize-phoenix-heroku)

## What is Arize Phoenix?

Arize Phoenix is an open-source LLM observability platform for ML practitioners to monitor, troubleshoot, and evaluate their generative AI applications. With Phoenix, you can:

- Debug issues like hallucinations and unresponsiveness
- Evaluate model performance across multiple dimensions
- Track fine-tuning progress
- Gain insights into latency, token usage, and cost
- Share dashboards with your team

## Deployment Options

### Option 1: One-Click Deploy

The easiest way to deploy Arize Phoenix on Heroku:

1. Click the "Deploy to Heroku" button above
2. Fill in the configuration options in the Heroku deployment page
3. Click "Deploy app"
4. Wait for the build to complete
5. Open your deployed Arize Phoenix instance

### Option 2: Manual Deployment

1. Clone this repository:
   ```
   git clone https://github.com/dsouza-anush/arize-phoenix-heroku.git
   cd arize-phoenix-heroku
   ```

2. Create a Heroku app:
   ```
   heroku create your-app-name
   ```

3. Set up Heroku PostgreSQL:
   ```
   heroku addons:create heroku-postgresql:hobby-dev
   ```

4. Set up Papertrail for logging (optional):
   ```
   heroku addons:create papertrail:choklad
   ```

5. Set environment variables (optional):
   ```
   heroku config:set PHOENIX_SECRET=your-secure-secret
   heroku config:set PHOENIX_ENABLE_AUTH=true
   ```

6. Configure Heroku to use container deployments:
   ```
   heroku stack:set container
   ```

7. Deploy to Heroku:
   ```
   git push heroku main
   ```

8. Open your app:
   ```
   heroku open
   ```

## Configuration

### Required Environment Variables

None! The app will work with default settings using SQLite or the automatically provisioned Heroku Postgres database.

### Optional Environment Variables

- `PHOENIX_SECRET`: Secret key for authentication (32+ characters with at least one digit and one lowercase letter)
- `PHOENIX_ENABLE_AUTH`: Enable authentication ("true"/"false")
- `PHOENIX_ADMIN_SECRET`: Admin authentication token
- `PHOENIX_TLS_ENABLED`: Enable TLS ("true"/"false")
- `TZ`: Timezone setting (default: "UTC")

## Sending Data to Phoenix

Once deployed, you can instrument your code to send data to Phoenix. See the [Phoenix documentation](https://docs.arize.com/phoenix/) for details.

### Python Example

```python
from phoenix.trace.client import Client
from phoenix import enable_openinference

# Initialize client
client = Client(url="https://your-app-name.herokuapp.com")

# Instrument your application
enable_openinference()

# Create a trace and spans will be sent to Phoenix
```

## Security Notes

- Always set a secure `PHOENIX_SECRET` when enabling authentication
- Consider using Heroku's SSL features for production deployments
- If using authentication, all users will need the secret to access Phoenix

## Resources

- [Arize Phoenix Documentation](https://docs.arize.com/phoenix/)
- [Heroku Container Registry Documentation](https://devcenter.heroku.com/articles/container-registry-and-runtime)

## Limitations

This Heroku deployment has some limitations compared to other hosting options:

1. Only HTTP OTLP collector is enabled (no gRPC)
2. Heroku's ephemeral filesystem means local data will be lost on dyno restarts
3. Free tier has limited resources and will sleep after 30 minutes of inactivity
4. Single dyno deployments have no built-in high availability

## Troubleshooting

### Application Crashes
Check logs with:
```
heroku logs --tail
```

### Database Connection Issues
Verify your database is properly provisioned:
```
heroku pg:info
```

### Memory Issues
Consider upgrading to a larger dyno type:
```
heroku dyno:resize web=standard-2x
```

## Contributing

Contributions are welcome! Please open an issue or pull request on GitHub.

## License

This deployment configuration is released under the MIT license. Arize Phoenix itself is subject to its own license terms.