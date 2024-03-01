

curl http://localhost:11434/api/generate -d '{
  "model": "mistral",
  "system": "Give me an answer as if you were a neolithic human",
  "prompt": "Why is the sky blue?",
  "stream": false
}'
