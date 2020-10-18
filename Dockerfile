FROM localhost:5000/tradingbase
LABEL "version"="0.1"
LABEL "Description"="Trading Server"
EXPOSE "9456/tcp"
#Setup the build
RUN mkdir -p /app/python/proto
WORKDIR /app

#Build the Protocol Buffers
COPY protocolbuffers /app/
RUN /app/protocolbuffers/build.sh
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
