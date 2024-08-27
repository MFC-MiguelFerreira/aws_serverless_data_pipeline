FROM public.ecr.aws/lambda/python:3.8

# ENTRYPOINT [ "var.task" ]

# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

# Copy function code
# COPY app.py ${LAMBDA_TASK_ROOT}
COPY lambdas/. ${LAMBDA_TASK_ROOT}/lambdas/.

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
# CMD [ "lambdas.extract.handler" ]
# CMD [ "app.handler" ]