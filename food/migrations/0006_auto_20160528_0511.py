# -*- coding: utf-8 -*-
# Generated by Django 1.9.6 on 2016-05-28 05:11
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('food', '0005_auto_20160522_1353'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='food',
            options={'ordering': ('-created',), 'verbose_name': '食品', 'verbose_name_plural': '食品'},
        ),
    ]