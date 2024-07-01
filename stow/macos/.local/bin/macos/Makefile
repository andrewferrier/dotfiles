all: getTrueName day-night-notifier

day-night-notifier: day-night-notifier-src/main.swift
	(cd day-night-notifier-src && make)
	cp day-night-notifier-src/.build/release/day-night-notifier .

getTrueName:
	gcc -o getTrueName -framework Carbon getTrueName.c
