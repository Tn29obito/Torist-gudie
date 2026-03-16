const fs = require('fs');
const file = 'c:\\Users\\ELCOT\\Desktop\\tori progect\\html\\interactive-prompt.html';

let content = fs.readFileSync(file, 'utf8');

const startMatch = '        async function handleInput(input) {';
const endMatch = '        function renderDest(dest) {';

const startIndex = content.indexOf(startMatch);
const endIndex = content.indexOf(endMatch);

if (startIndex !== -1 && endIndex !== -1) {
  const grokCode = `        const GROK_API_KEY = localStorage.getItem('GROK_API_KEY') || prompt('Please enter your xAI (Grok) API Key to enable the AI Concierge:');
        if (GROK_API_KEY) {
            localStorage.setItem('GROK_API_KEY', GROK_API_KEY);
        }

        let chatHistory = [
            {
                role: 'system',
                content: \`You are Tori AI, an expert travel concierge for Tour India. Provide highly detailed, well-structured travel itineraries, destination recommendations, and budget estimates for India. Format with readable spacing. Use Markdown for bolding (**text**) and lists, but keep it concise and punchy. Tone: futuristic, helpful, and professional. Do NOT use markdown headers (#), just bold text and bullet points.\`
            }
        ];

        async function handleInput(input) {
            if (!input.trim()) return;

            addMessage(input, 'user');
            userInput.value = '';

            showTyping();
            
            chatHistory.push({ role: 'user', content: input });

            try {
                if (!GROK_API_KEY) {
                    throw new Error("No API Key provided.");
                }

                const response = await fetch('https://api.x.ai/v1/chat/completions', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': \`Bearer \${GROK_API_KEY}\`
                    },
                    body: JSON.stringify({
                        messages: chatHistory,
                        model: 'grok-beta',
                        stream: false,
                        temperature: 0.7
                    })
                });

                removeTyping();

                if (!response.ok) {
                    const errorText = await response.text();
                    console.error("Grok API Error:", errorText);
                    addMessage(\`API_ERROR: Unable to connect to Grok AI. (\${response.status}) Verify your API key.\`, 'bot');
                    return;
                }

                const data = await response.json();
                const botReply = data.choices[0].message.content;
                
                chatHistory.push({ role: 'assistant', content: botReply });
                
                // Format markdown bolding for the custom HTML
                const formattedHtml = botReply
                    .replace(/\\*/g, '') // remove unsupported markdown for now, keep it simple
                    .replace(/\\n/g, '<br>');
                
                addMessage('', 'bot', null, \`<div style="line-height: 1.6; margin-top: 10px; color: #e0e0e0; font-size: 0.95em;">\${formattedHtml}</div>\`);
            } catch (error) {
                removeTyping();
                console.error("Network Error:", error);
                if (error.message.includes("API Key")) {
                    addMessage("AUTH_ERROR: Grok API Key is missing. Please refresh and enter your key.", 'bot');
                } else {
                    addMessage("NETWORK_ERROR: Connection to neural network failed.", 'bot');
                }
            }
        }

`;
  
  const newContent = content.slice(0, startIndex) + grokCode + content.slice(endIndex);
  fs.writeFileSync(file, newContent);
  console.log('Successfully updated interactive-prompt.html with Grok AI implementation.');
} else {
  console.log('Could not find the target code blocks. Start:', startIndex !== -1, 'End:', endIndex !== -1);
}
