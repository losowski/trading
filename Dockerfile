FROM localhost:5000/tradingbase
LABEL "version"="0.1"
LABEL "Description"="Trading Server"
EXPOSE "9456/tcp"
WORKDIR /app
#Build the Protocol Buffers
COPY protocolbuffers .
RUN protocolbuffers/build.sh
COPY python /app

#Copy Database configuration
COPY xml /app

#Copy relevant files
COPY stockTickerAPI.py /app
COPY queryStock.py /app
COPY symbol.py /app
COPY stockQuote.py /app

#Run the Ticker
CMD app/stockTickerAPI.py
