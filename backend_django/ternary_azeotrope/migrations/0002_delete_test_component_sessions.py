# Generated by Django 4.1.6 on 2023-02-17 15:24

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("sessions", "0001_initial"),
        ("ternary_azeotrope", "0001_initial"),
    ]

    operations = [
        migrations.DeleteModel(
            name="Test",
        ),
        migrations.AddField(
            model_name="component",
            name="sessions",
            field=models.ManyToManyField(
                blank=True, related_name="sessions", to="sessions.session"
            ),
        ),
    ]