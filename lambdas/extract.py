def handler(event, context):
    print("Hello World from EXTRACT Lambda Deployed From Docker")
    print(f"Event: {event}")
    return event