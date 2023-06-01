# fencing_tracker

The app is a tracker for fencing practice (and maybe competition later on).

## Features

 - Create practices
 - Create fencer
 - Create matches
	 - Several modes: 5T BO1 ; 5T BO3 ; 10T ; 15T
 - See Stats
	 -  by practice
	 -  by fencer

## Basic init data

User:
 - Name
 - Club

## Stats

 - Winrate
 - Given touches by win/lose
 - Received touches by win/lose

## Pages

- Home w/ stats
- List opponents
- List practices
- Current practice
- Stats

## Isar database

Add `part 'class_name.g.dart'` to the collection class.

Run `flutter pub run build_runner build` to do the migration (generate the code needed to use the table).