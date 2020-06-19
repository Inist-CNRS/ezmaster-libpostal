import postal from '@cymen/node-postal';

export default function parseAddress(data, feed) {
    if (this.isLast()) {
        return feed.close();
    }
    if (typeof data !== 'string') {
        return feed.send(data);
    }
    const addresses = postal.parser.parse_address(data.trim());
    const result = addresses.reduce((obj, cur) => ({ ...obj, [cur.component]: cur.value }), {});
    return feed.send(result);
}
