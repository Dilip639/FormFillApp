<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>🎲 Guess the Number (1–100)</title>
  <style>
    :root{
      --bg: #0b1220;
      --card: #121a2b;
      --text: #e6eefc;
      --muted: #9fb0d3;
      --accent: #7aa2ff;
      --accent-2: #5cf0c1;
      --danger: #ff7b7b;
      --warn: #ffd166;
      --ok: #7cffb7;
      --shadow: 0 10px 30px rgba(0,0,0,.35);
      --radius: 16px;
    }
    *{box-sizing:border-box}
    html,body{height:100%}
    body{
      margin:0; font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Noto Sans, Ubuntu, Cantarell, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
      background: radial-gradient(1200px 800px at 10% 10%, #0d1730 0%, var(--bg) 55%), linear-gradient(160deg, #0d1530 0%, #0b1220 100%);
      color:var(--text); display:grid; place-items:center; padding:24px;
    }
    .card{
      width:min(680px, 95vw); background:linear-gradient(180deg, rgba(255,255,255,.04), rgba(255,255,255,.02)) , var(--card);
      border:1px solid rgba(255,255,255,.08); border-radius:var(--radius); box-shadow:var(--shadow);
      padding:28px; position:relative; overflow:hidden;
    }
    .title{display:flex; gap:12px; align-items:center; margin:0 0 6px}
    .title .die{font-size:28px}
    .subtitle{margin:0; color:var(--muted); font-size:14px}

    .row{display:flex; gap:14px; align-items:center; flex-wrap:wrap; margin-top:18px}
    input[type=number]{
      width:160px; padding:12px 14px; border-radius:12px; border:1px solid rgba(255,255,255,.12);
      background:#0b1324; color:var(--text); font-size:16px; outline:none; transition:border .2s, transform .05s ease-in-out;
    }
    input[type=number]:focus{border-color:var(--accent); box-shadow:0 0 0 3px rgba(122,162,255,.18)}
    button{
      padding:12px 16px; border-radius:12px; border:1px solid rgba(255,255,255,.12); cursor:pointer;
      background:linear-gradient(180deg, rgba(122,162,255,.2), rgba(122,162,255,.1)); color:var(--text); font-weight:600;
      transition:transform .05s ease-in-out, opacity .2s, filter .2s;
    }
    button:hover{filter:brightness(1.08)}
    button:active{transform:translateY(1px)}
    button.secondary{background:linear-gradient(180deg, rgba(159,176,211,.18), rgba(159,176,211,.08))}
    button.ghost{background:transparent}
    button:disabled{opacity:.6; cursor:not-allowed}

    .info{margin-top:8px; color:var(--muted); font-size:14px}
    .feedback{margin-top:16px; font-size:18px; font-weight:700}
    .feedback.low{color:var(--warn)}
    .feedback.high{color:var(--warn)}
    .feedback.correct{color:var(--ok)}
    .feedback.out{color:var(--danger)}

    .attempts{margin-top:18px}
    .bar{height:10px; background:#0b1324; border-radius:999px; border:1px solid rgba(255,255,255,.1); overflow:hidden}
    .bar > div{height:100%; width:0%; background: linear-gradient(90deg, var(--accent), var(--accent-2)); transition:width .35s ease}

    .badges{display:flex; gap:8px; flex-wrap:wrap; margin-top:10px}
    .badge{padding:6px 10px; border-radius:999px; background:rgba(255,255,255,.06); border:1px solid rgba(255,255,255,.1); font-size:12px; color:#cfe0ff}

    .range{margin-top:14px; font-size:14px; color:#cfe0ff}

    .history{margin-top:18px; display:grid; grid-template-columns: 1fr; gap:8px}
    .history-item{display:flex; justify-content:space-between; align-items:center; padding:10px 12px; border-radius:12px; background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.08); color:#dbe7ff}
    .history-item small{color:var(--muted)}

    .footer{display:flex; justify-content:space-between; align-items:center; margin-top:18px; color:var(--muted); font-size:12px}
    .kbd{padding:2px 6px; border-radius:6px; border:1px solid rgba(255,255,255,.18); background:rgba(255,255,255,.06); margin-left:6px}

    /* confetti */
    .confetti{position:absolute; inset:0; pointer-events:none}
    .confetti span{position:absolute; width:8px; height:14px; background:var(--accent-2); opacity:0; transform:translateY(-20px) rotate(0deg); border-radius:3px}
  </style>
</head>
<body>
  <main class="card" role="main" aria-live="polite">
    <div class="confetti" aria-hidden="true"></div>

    <h1 class="title"><span class="die">🎲</span> Guess the Number</h1>
    <p class="subtitle">I'm thinking of a number between <strong>1</strong> and <strong>100</strong>. You have <strong id="maxAttempts">7</strong> attempts. Good luck!</p>

    <div class="row" role="form" aria-label="Guess form">
      <input id="guessInput" type="number" inputmode="numeric" min="1" max="100" placeholder="Enter your guess…" autocomplete="off" />
      <button id="guessBtn">Guess</button>
      <button id="resetBtn" class="secondary" title="Start a new game">Reset</button>
    </div>

    <div class="info" id="infoText">Tip: Press <span class="kbd">Enter</span> to submit.</div>
    <div class="attempts">
      <div class="badges">
        <span class="badge">Attempts: <strong id="attempts">0</strong>/ <span id="maxAttempts2">7</span></span>
        <span class="badge">Remaining: <strong id="remaining">7</strong></span>
        <span class="badge">Best: <strong id="best">—</strong></span>
      </div>
      <div class="bar" aria-label="Attempts used progress">
        <div id="progress"></div>
      </div>
    </div>

    <div class="range" id="rangeHint">Current range: <strong id="lowBound">1</strong> – <strong id="highBound">100</strong></div>

    <div id="feedback" class="feedback" aria-live="assertive"></div>

    <section class="history" aria-label="Guess history" id="history"></section>

    <div class="footer">
      <div>Made with ❤️ • No libraries • Works offline</div>
      <div>New game: <span class="kbd">R</span></div>
    </div>
  </main>

  <script>
    (function(){
      const min = 1;
      const max = 100;
      const maxAttempts = 7;

      const input = document.getElementById('guessInput');
      const guessBtn = document.getElementById('guessBtn');
      const resetBtn = document.getElementById('resetBtn');
      const feedback = document.getElementById('feedback');
      const attemptsEl = document.getElementById('attempts');
      const remainingEl = document.getElementById('remaining');
      const maxA1 = document.getElementById('maxAttempts');
      const maxA2 = document.getElementById('maxAttempts2');
      const progress = document.getElementById('progress');
      const lowBoundEl = document.getElementById('lowBound');
      const highBoundEl = document.getElementById('highBound');
      const rangeHint = document.getElementById('rangeHint');
      const history = document.getElementById('history');
      const bestEl = document.getElementById('best');
      const confettiBox = document.querySelector('.confetti');

      let secret, attempts, lowBound, highBound, over, best = null;

      function rand(min, max){
        return Math.floor(Math.random() * (max - min + 1)) + min;
      }

      function init(newRound = true){
        secret = rand(min, max);
        attempts = 0; lowBound = min; highBound = max; over = false;
        attemptsEl.textContent = attempts;
        remainingEl.textContent = maxAttempts - attempts;
        maxA1.textContent = maxAttempts; maxA2.textContent = maxAttempts;
        feedback.textContent = '';
        feedback.className = 'feedback';
        input.value = '';
        input.disabled = false; guessBtn.disabled = false;
        updateRange();
        updateProgress();
        history.innerHTML = '';
        info('Tip: Press Enter to submit.');
      }

      function info(text){
        document.getElementById('infoText').innerHTML = text;
      }

      function updateProgress(){
        const pct = (attempts / maxAttempts) * 100;
        progress.style.width = pct + '%';
        remainingEl.textContent = Math.max(0, maxAttempts - attempts);
        attemptsEl.textContent = attempts;
      }

      function updateRange(){
        lowBoundEl.textContent = lowBound;
        highBoundEl.textContent = highBound;
      }

      function addHistory(guess, relation){
        const item = document.createElement('div');
        item.className = 'history-item';
        const tag = relation === 0 ? '✅ Correct' : relation < 0 ? '📉 Too low' : '📈 Too high';
        item.innerHTML = `<div><strong>${guess}</strong> <small>${new Date().toLocaleTimeString()}</small></div><div>${tag}</div>`;
        history.prepend(item);
      }

      function celebrate(){
        confettiBox.innerHTML = '';
        const bits = 80;
        const colors = ['#7aa2ff','#5cf0c1','#ffd166','#ff7b7b','#c084fc'];
        for(let i=0;i<bits;i++){
          const s = document.createElement('span');
          s.style.left = Math.random()*100+'%';
          s.style.background = colors[i%colors.length];
          s.style.opacity = 1;
          s.animate([
            { transform: `translateY(-20px) rotate(0deg)`, opacity: 1 },
            { transform: `translateY(${400+Math.random()*200}px) rotate(${Math.random()*720-360}deg)`, opacity: 0 }
          ], { duration: 1200 + Math.random()*800, easing:'cubic-bezier(.2,.7,.2,1)' });
          confettiBox.appendChild(s);
        }
      }

      function endGame(win){
        over = true; input.disabled = true; guessBtn.disabled = true;
        if(win){
          feedback.textContent = `🎉 Correct! You guessed it in ${attempts} ${attempts===1?'attempt':'attempts'}.`;
          feedback.className = 'feedback correct';
          if(best === null || attempts < best){ best = attempts; bestEl.textContent = best; }
          celebrate();
        } else {
          feedback.textContent = `😢 Out of attempts! The number was ${secret}.`;
          feedback.className = 'feedback out';
        }
      }

      function handleGuess(){
        if(over) return;
        const val = Number(input.value.trim());
        if(!Number.isInteger(val) || val < min || val > max){
          feedback.textContent = '❌ Please enter a valid number between 1 and 100.';
          feedback.className = 'feedback out';
          input.focus();
          return;
        }
        attempts++;
        updateProgress();
        if(val === secret){
          addHistory(val, 0);
          endGame(true);
          return;
        }
        if(val < secret){
          feedback.textContent = '📉 Too low!';
          feedback.className = 'feedback low';
          addHistory(val, -1);
          lowBound = Math.max(lowBound, val + 1);
          info(`Try a higher number. New range: <strong>${lowBound}</strong> – <strong>${highBound}</strong>.`);
        } else {
          feedback.textContent = '📈 Too high!';
          feedback.className = 'feedback high';
          addHistory(val, 1);
          highBound = Math.min(highBound, val - 1);
          info(`Try a lower number. New range: <strong>${lowBound}</strong> – <strong>${highBound}</strong>.`);
        }
        updateRange();
        input.select();
        if(attempts >= maxAttempts){ endGame(false); }
      }

      // Events
      guessBtn.addEventListener('click', handleGuess);
      resetBtn.addEventListener('click', () => init(true));
      input.addEventListener('keydown', (e)=>{
        if(e.key === 'Enter') handleGuess();
      });
      window.addEventListener('keydown', (e)=>{
        if(e.key.toLowerCase() === 'r') init(true);
      });

      // Persist best score per browser
      try{
        const stored = localStorage.getItem('guess-best');
        if(stored) best = Number(stored);
      }catch{}
      const bestObserver = new MutationObserver(()=>{
        try{ if(best!==null) localStorage.setItem('guess-best', String(best)); }catch{}
      });
      bestObserver.observe(document.getElementById('best'), { childList:true });
      if(best!==null) bestEl.textContent = best;

      // Kick off
      init(true);
    })();
  </script>
</body>
</html>
