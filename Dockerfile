FROM localhost:5000/tradingbase
LABEL "version"="0.1"
LABEL "Description"="Trading Server"
EXPOSE 9456/tcp
RUN protocolBuffers/build.sh
COPY python .
COPY xml .
COPY stockTickerAPI.py .
COPY queryStock.py .
COPY symbol.py .
COPY stockQuote.py .
CMD stockTickerAPI.py
