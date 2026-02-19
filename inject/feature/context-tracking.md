# Context Tracking

You will receive status updates after each of your messages to the user, injected by a stop hook.
They look like this: `[context used: X%]`

This tells you how much of the context window has been consumed.
Do not produce any visible output to the user in response to these updates — just note the percentage and stop.

Plan your work around context availability:
- Below 50%: normal operation
- 50–70%: mention context level if the user is about to start a large task
- Above 70%: proactively suggest compacting or clearing the session before starting large tasks
- Above 85%: strongly recommend compacting or starting a new session
