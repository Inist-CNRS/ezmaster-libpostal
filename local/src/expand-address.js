import postal from '@cymen/node-postal';

export default function parseAddress(data, feed) {
    if (this.isLast()) {
        return feed.close();
    }
    if (typeof data !== 'string') {
        return feed.send(data);
    }
    const result = postal.expand.expand_address(data.trim());
    return feed.send(result);
}
