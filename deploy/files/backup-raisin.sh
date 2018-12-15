#!/bin/bash

sudo -u postgres pg_dump raisin > /opt/backups/raisin-`date +%FT%R`.sql
