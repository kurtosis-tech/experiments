import http.server
import os
import socketserver
import time

import psycopg2

# Simple REST API with GET handler reading from a postgres DB
def main():
    postgres_url = os.environ["POSTGRES_URL"]
    conn = psycopg2.connect(postgres_url)

    port = 443
    with socketserver.TCPServer(("", port), make_handler(conn)) as httpd:
        print("serving at port", port)
        httpd.serve_forever()
    

def make_handler(db_conn):

    class GetHandler(http.server.BaseHTTPRequestHandler):
        def _set_headers(self):
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()

        def do_GET(self):
            with db_conn.cursor() as cur:
                cur.execute("SELECT")
                row = cur.fetchone()
                self._set_headers()
                self.wfile.write(row)

    return GetHandler


if __name__ == "__main__":
    main()
