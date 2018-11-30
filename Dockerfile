FROM mikeifomin/midas_wallet_base:v1-zeromq-dev

WORKDIR /usr/local/bin

COPY ./aprcoind .
COPY ./aprcoin-cli .

RUN chmod +x ./* && \
    ln aprcoind walletd && \
    ln aprcoin-cli wallet-cli

VOLUME ["/root/.aprcoin"]
EXPOSE 3133

RUN walletd --help || exit $(($? == 127))
