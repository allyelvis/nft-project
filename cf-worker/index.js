addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  const url = new URL(request.url)
  const ipfsHash = url.pathname.split('/').pop()
  const ipfsUrl = `https://cloudflare-ipfs.com/ipfs/${ipfsHash}`

  const response = await fetch(ipfsUrl)
  const data = await response.json()

  return new Response(JSON.stringify(data), {
    headers: { 'Content-Type': 'application/json' }
  })
}
