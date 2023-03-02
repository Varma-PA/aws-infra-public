#!/bin/bash
sudo systemctl daemon-reload
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable webapp
sudo systemctl start webapp
