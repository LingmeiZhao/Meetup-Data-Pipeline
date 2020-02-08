#!/bin/bash

while read line; do
	echo $line | python process_comment.py
done < <(curl -s http://stream.meetup.com/2/event_comments)
