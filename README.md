# docker-file-backup

This container can be used to periodically run an artisan command.

Example usage which will backup the source file or folder every day at 03:00. You can check the last run with the integrated HTTP server on port 18080:

```bash
docker run -d \
-v /var/data:/var/data
-v /var/scripts:/var/scripts \
-p 18080:18080 \
-e SCHEDULE="0 0 3 * *" \
-e TASK=artisantask
dylangmiles/docker-laravel-artisan-cron
```
