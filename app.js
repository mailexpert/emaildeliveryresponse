
document.getElementById('checkBtn').addEventListener('click', async () => {
  const email = document.getElementById('emailInput').value.trim();
  if (!email) {
    alert('Please enter a valid email address.');
    return;
  }

  const hashedEmail = await hashEmail(email);
  await checkHashedEmail(hashedEmail, email);
});

const bulkResults = [];

async function hashEmail(email) {
  const encoder = new TextEncoder();
  const data = encoder.encode(email);
  const hashBuffer = await crypto.subtle.digest('SHA-256', data);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

domain='https://emaildelivery.space/me/check/'

async function checkHashedEmail(hashedEmail, rawEmail = '') {
  try {
    const response = await fetch(domain+`${hashedEmail}`);
    const result = await response.json();

    if (rawEmail) {
      bulkResults.push({ email: rawEmail, ...result });
      updateTableDisplay();
    } else {
      document.getElementById('resultData').textContent = JSON.stringify(result, null, 2);
      document.getElementById('result').classList.remove('hidden');
    }
  } catch (error) {
    if (rawEmail) {
      bulkResults.push({ email: rawEmail, error: error.message });
      updateTableDisplay();
    } else {
      document.getElementById('resultData').textContent = `Error: ${error.message}`;
      document.getElementById('result').classList.remove('hidden');
    }
  }
}

function updateTableDisplay() {
  const table = document.getElementById('resultsTable');
  table.innerHTML = '<tr><th class="border px-2 py-1">Email</th><th class="border px-2 py-1">Status</th><th class="border px-2 py-1">Send Date</th><th>Delivered date</th><th class="border px-2 py-1">Verified</th><th>Hard Bounce</th><th>Soft Bounce</th></tr>';
  bulkResults.forEach(r => {
    console.log('r is :'+JSON.stringify(r));
    table.innerHTML += `
      <tr>
        <td class="border px-2 py-1">${r.email}</td>
        <td class="border px-2 py-1">${r.status || r.error || 'unknown'}</td>
        <td class="border px-2 py-1">${r.send_date || '-'}</td>
        <td class="border px-2 py-1">${r.delivered_date || '-'}</td>
        <td class="border px-2 py-1">${r.source_verified === 1 ? '✅' : r.source_verified === 0 ? '❌' : '-'}</td>
        <td class="border px-2 py-1">${r.hard_bounce_reason || '-'}</td>
        <td class="border px-2 py-1">${r.soft_bounce_reason || '-'}</td>
      </tr>
    `;
  });
}
