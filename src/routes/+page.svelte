<script lang="ts">
  import { browser } from '$app/environment';
  import logoFull from '$lib/assets/logo-full.svg?raw';
  import deathsDoor from '$lib/assets/deathsdoor.ogg';
  import stressUp from '$lib/assets/stressup.ogg';
  import campaignButton from '$lib/assets/campaignbutton.ogg';

  let graveyardSound: HTMLAudioElement;
  let copySound: HTMLAudioElement;

  let copied = $state(false);
  let muted = $state(false);

  if (browser) {
    graveyardSound = new Audio(deathsDoor);
    graveyardSound.volume = 1.0;
    graveyardSound.preload = 'auto';
    graveyardSound.load();
    graveyardSound.muted = muted;

    copySound = new Audio(campaignButton);
    copySound.volume = 1.0;
    copySound.preload = 'auto';
    copySound.load();
    copySound.muted = muted;
  }

  const deathList = [
    { player: 'Dream_Fan12', cause: 'slime' },
    { player: 'just_a_steve', cause: 'falling', meta: 46 },
    { player: 'TommyGaming_', cause: 'creeper' },
    { player: 'roomeyZez', cause: 'killed', meta: 'Zenbog' },
    { player: 'xPPc1s', cause: 'lightning' },
    { player: 'StoneBridge47', cause: 'falling', meta: 38 },
    { player: 'popbob', cause: 'drowning' },
    { player: 'paddington49', cause: 'burning' },
    { player: 'vopiX', cause: 'ghast' },
    { player: 'kolanii', cause: 'enderman' },
    { player: 'artifiiiicer', cause: 'explosion' },
  ];

  function handleCopyUrl() {
    if (copySound) {
      copySound.pause();
      copySound.currentTime = 0;
      copySound.play();
    }
    navigator.clipboard.writeText('mc.voidheart.net');
    copied = true;
  }
  function handleDeathAnimation() {
    const element = document.documentElement;
    if (graveyardSound) {
      graveyardSound.pause();
      graveyardSound.currentTime = 0;
      graveyardSound.play();
    }

    element.classList.remove('flash');
    void element.offsetWidth;
    element.classList.add('flash');

    element.addEventListener(
      'animationend',
      () => {
        element.classList.remove('flash');
      },
      { once: true }
    );
  }
</script>

<div class="main">
  <div class="left panel">
    <div class="logo-block">
      {@html logoFull}
      <h1>Hardcore survival Minecraft server</h1>
    </div>
    <div class="content">
      <div class="rules part">
        <h3>Rules & Conditions:</h3>
        <ul>
          <li>Temporary <em>ban on death</em> for 16hrs</li>
          <li>One Totem of Undying given to everybody</li>
          <li>Time is locked to 02:30am (permadark)</li>
        </ul>
        <p><br /></p>
        <p><a href="#">Read all rules</a></p>
      </div>
      <div class="join-server part">
        <p>Join the server now:</p>
        <button type="button" class="server-url" on:click={handleCopyUrl}>
          <svg
            class="icon-globe"
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            ><path
              fill="currentColor"
              d="M22 9V7h-1V5h-1V4h-1V3h-2V2h-2V1H9v1H7v1H5v1H4v1H3v2H2v2H1v7h1v1h1v2h1v1h1v1h2v1h2v1h6v-1h2v-1h2v-1h1v-1h1v-2h1v-2h1V9zm-1 1v4h-3v-4zm-5-6h1v1h2v2h1v1h-3V5h-1zm-2 14v2h-1v1h-2v-1h-1v-2H9v-2h6v2zm2-8v4H8v-4zM9 6h1V4h1V3h2v1h1v2h1v2H9zM4 7h1V5h2V4h1v1H7v3H4zm-1 7v-4h3v4zm2 5v-2H4v-1h3v3h1v1H7v-1zm14-2v2h-2v1h-1v-1h1v-3h3v1z"
            /></svg
          >
          <span class="url">mc.voidheart.net</span>
          <div class="action" class:copied>
            {#if copied}
              Copied!
            {:else}
              Copy
            {/if}
          </div>
        </button>
        <table class="info-table">
          <tbody>
            <tr>
              <td class="title">Players online</td>
              <td class="value"
                ><span class="players-online">3</span> <span class="slash">/</span> 10</td
              >
            </tr>
            <tr>
              <td class="title">Awaiting revival</td>
              <td class="value"><span class="current-dead">13 dead</span></td>
            </tr>
            <tr>
              <td class="title">Longest alive</td>
              <td class="value"
                ><span class="longest-alive">DeDementEd</span>
                <span class="nobreak">(96h 12m)</span></td
              >
            </tr>
            <tr>
              <td class="title">Total deaths</td>
              <td class="value">144,373</td>
            </tr>
            <tr>
              <td colspan="2" class="spacer"></td>
            </tr>
            <tr>
              <td class="title">Game version</td>
              <td class="value"><em>1.21.6</em> <span class="nobreak">(Java Edition)</span></td>
            </tr>
            <tr>
              <td class="title">Uptime</td>
              <td class="value">99.7% (<a href="#">Status</a>)</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <div class="right panel">
    <div class="graveyard-list" on:click={handleDeathAnimation}>
      <div class="header">
        <h2>
          Graveyard <svg
            width="36"
            height="36"
            class="grave-icon"
            viewBox="0 0 36 36"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path d="M4 32H32V33H4V32Z" fill="currentColor" />
            <path d="M6 31H30V32H6V31Z" fill="currentColor" />
            <path d="M8 30H28V31H8V30Z" fill="currentColor" />
            <path d="M10 29H26V30H10V29Z" fill="currentColor" />
            <path d="M12 28H24V29H12V28Z" fill="currentColor" />
            <path d="M7 27H9V28H7V27Z" fill="currentColor" />
            <path d="M27 27H29V28H27V27Z" fill="currentColor" />
            <path d="M7 26H11V27H7V26Z" fill="currentColor" />
            <path d="M10 4H26V6H10V4Z" fill="currentColor" />
            <path d="M12 3H24V4H12V3Z" fill="currentColor" />
            <path d="M25 26H29V27H25V26Z" fill="currentColor" />
            <path
              fill-rule="evenodd"
              clip-rule="evenodd"
              d="M27 6H9V8H8V9V10H7V26H29V10H28V9V8H27V6ZM16.5 8V9V10V12H12V15H16.5V24H19.5V15H24V12H19.5V10V9V8V7H16.5V8Z"
              fill="currentColor"
            />
          </svg>
        </h2>
        <div
          class="audio-toggle"
          on:click={(event) => {
            event.stopPropagation();
            if (graveyardSound) {
              muted = !muted;
              graveyardSound.muted = muted;
              copySound.muted = muted;
            }
          }}
        >
          {#if muted}<svg
              class="icon negative"
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              ><!-- Icon from Pixel Icon by HackerNoon - https://creativecommons.org/licenses/by/4.0/ --><path
                fill="currentColor"
                d="M14 2v20h-3v-1h-1v-1H9v-1H8v-1H7v-1H6v-1H1V8h5V7h1V6h1V5h1V4h1V3h1V2zm8 6v2h-1v1h-1v2h1v1h1v2h-2v-1h-1v-1h-1v1h-1v1h-2v-2h1v-1h1v-2h-1v-1h-1V8h2v1h1v1h1V9h1V8z"
              /></svg
            >{:else}<svg
              class="icon"
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              ><!-- Icon from Pixel Icon by HackerNoon - https://creativecommons.org/licenses/by/4.0/ --><path
                fill="currentColor"
                d="M14 2v20h-3v-1h-1v-1H9v-1H8v-1H7v-1H6v-1H1V8h5V7h1V6h1V5h1V4h1V3h1V2zm3 13v-1h-1v-1h1v-2h-1v-1h1V9h1v1h1v4h-1v1z"
              /><path
                fill="currentColor"
                d="M23 10v4h-1v2h-1v1h-1v1h-1v-1h-1v-1h1v-1h1v-1h1v-4h-1V9h-1V8h-1V7h1V6h1v1h1v1h1v2z"
              /></svg
            >{/if}
        </div>
      </div>
      <p>Last 10 deaths</p>
      <div class="list">
        {#each deathList as death}
          <div class="item">
            <svg
              width="22"
              height="22"
              class="icon"
              viewBox="0 0 22 22"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M19.8 2.19995H2.19995V19.8H19.8V2.19995ZM5.49995 4.39995H7.69995V5.49995H5.49995V4.39995ZM7.69995 4.39995V3.29995H8.79995V4.39995H7.69995ZM4.39995 7.69995H9.89995V8.79995H8.79995V9.89995H7.69995V12.1H6.59995V9.89995V8.79995H4.39995V7.69995ZM6.59995 13.2H7.69995V14.3H6.59995V13.2ZM13.2 15.4H8.79995V16.5H13.2V15.4ZM14.3 12.1H15.4V13.2H14.3V12.1ZM15.4 9.89995V11H14.3V9.89995H13.2V8.79995H12.1V7.69995H17.6V8.79995H15.4V9.89995ZM16.5 4.39995H14.3V3.29995H13.2V4.39995H14.3V5.49995H16.5V4.39995Z"
                fill="#9F2020"
              />
            </svg>
            <div class="value">
              <em>{death.player}</em> died from {death.cause}
              {#if death.meta}
                {#if typeof death.meta === 'number'}
                  {death.meta} blocks high
                {:else}
                  by {death.meta}
                {/if}
              {/if}
            </div>
          </div>
        {/each}
      </div>
    </div>
    <a href="#" class="discord-button">
      <svg
        class="discord-icon"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M22 11V8H21V6H20V5H18V4H15V5H9V4H6V5H4V6H3V8H2V11H1V18H3V19H5V20H7V18H6V17H8V18H9V19H15V18H16V17H18V18H17V20H19V19H21V18H23V11H22ZM9 15H7V14H6V12H7V11H9V12H10V14H9V15ZM18 14H17V15H15V14H14V12H15V11H17V12H18V14Z"
          fill="currentColor"
        />
      </svg>
      <span>Join VOID<span class="effect">&#x2764;</span>HEART on Discord</span>
    </a>
  </div>
</div>

<style lang="scss">
  @keyframes throb {
    0% {
      transform: scale(1.25);
      color: var(--color-dark-red);
    }
    100% {
      transform: scale(1);
    }
  }
  @property --angle {
    syntax: '<angle>';
    initial-value: 0deg;
    inherits: false;
  }
  @keyframes borderAnimation {
    0% {
      --angle: 0deg;
    }
    50% {
      --angle: 180deg;
      filter: brightness(1.15);
    }
    100% {
      --angle: 360deg;
    }
  }
  .main {
    max-width: 1440px;
    padding-block: 4rem;
    margin: 0 auto;
    width: 100%;
    padding-inline: 2.5rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
    min-height: 100%;
    flex-wrap: wrap;
    row-gap: 3rem;
    @media screen and (max-width: 1600px) {
      max-width: 1280px;
    }
    @media screen and (max-width: 768px) {
      padding-inline: 1.5rem;
    }
    .logo-block {
      margin-bottom: 4rem;
      :global(.logo) {
        margin-bottom: 0.75rem;
        margin-left: -0.5rem;
        max-width: 100%;
      }
      h1 {
        font-size: 1.25rem;
        line-height: 1.4;
        color: var(--color-foreground);
      }
    }
    .content {
      .part {
        &:not(:first-child) {
          margin-top: 3rem;
        }
      }
    }
    .rules {
      p {
        margin-block: 0.375rem;
      }
      em {
        color: var(--color-red);
      }
      ul {
        list-style-type: square;
        list-style-position: inside;
        li {
          margin-block: 0.375rem;
        }
      }
    }
    .join-server {
      .server-url {
        display: flex;
        align-items: center;
        padding: 1rem;
        border: 2px solid rgba(white, 0.06);
        background:
          linear-gradient(#131219, #131219) padding-box,
          rgba(white, 0.06) border-box;
        margin-top: 0.75rem;
        width: fit-content;
        transition: var(--transition-fast);
        .icon-globe {
          margin-right: 0.75rem;
        }
        .url {
          text-transform: uppercase;
          color: var(--color-foreground);
        }
        .action {
          font-size: 0.75rem;
          color: var(--color-link);
          padding: 0.5rem 0.625rem;
          line-height: 1.6;
          margin-block: -0.5rem;
          &.copied {
            color: var(--color-green);
          }
        }
        &:hover {
          box-shadow: 0 0 2rem 0 var(--color-link-glow);
          background:
            linear-gradient(#0a090d, #0a090d) padding-box,
            conic-gradient(
                from var(--angle),
                var(--color-blue-grad),
                var(--color-link-glow),
                var(--color-link-glow),
                var(--color-blue),
                var(--color-link-glow),
                var(--color-link-glow),
                var(--color-blue-grad)
              )
              border-box;
          animation: 2s borderAnimation linear infinite;
          .action:not(.copied) {
            color: var(--color-link-hover);
          }
        }
        &:active {
          transform: translateY(0.0625rem);
          animation-play-state: paused;
          opacity: 0.64;
          filter: grayscale(1);
        }
      }
    }
    .info-table {
      margin-top: 2rem;
      font-size: 0.875rem;
      line-height: 1.6;
      border-spacing: 8px;
      tr {
        td {
          padding-block: 0.125rem;
        }
      }
      .spacer {
        height: 1em;
      }
      .longest-alive {
        color: var(--color-gold);
      }
      .current-dead {
        color: var(--color-dark-red);
      }
      .players-online {
        color: var(--color-green);
      }
      .slash {
        color: var(--color-dark-gray);
      }
      em {
        color: var(--color-foreground);
      }
      .title {
        padding-right: 1rem;
        color: var(--color-dark-gray);
        white-space: nowrap;
      }
      .nobreak {
        white-space: nowrap;
      }
    }
    .graveyard-list {
      background-color: hsla(0, 33%, 10%, 0.46);
      box-shadow: 0 0 2rem 0 hsla(0, 58%, 25%, 0.24);
      backdrop-filter: blur(1rem);
      width: 100%;
      max-width: 420px;
      border: 2px solid #661b1b;
      padding: 2rem 2rem 3rem;
      padding: 2rem;
      .header {
        display: flex;
        align-items: center;
        .audio-toggle {
          margin-left: auto;
          font-size: 1.5rem;
          .icon {
            color: var(--color-foreground);
            &.negative {
              color: var(--color-dark-gray);
            }
          }
        }
      }
      h2 {
        display: flex;
        align-items: center;
        font-size: 2rem;
        margin-bottom: 0.25rem;
        color: var(--color-red);
        line-height: 1.375;
        .grave-icon {
          margin-left: 0.5rem;
        }
      }
      p {
        color: var(--color-dark-red);
        font-size: 0.875rem;
        line-height: 1.6;
      }
      .list {
        color: var(--color-dark-red);
        margin-top: 2rem;
        max-height: 50vh;
        min-height: 240px;
        overflow-y: auto;
        scrollbar-width: thin;
        scrollbar-color: var(--color-red) transparent;
        margin-right: -1rem;
        padding-right: 1rem;
        .item {
          font-size: 0.875rem;
          line-height: 1.6;
          display: flex;
          gap: 0.75rem;
          .icon {
            width: 1.375rem;
            height: 1.375rem;
            flex-shrink: 0;
          }
          &:not(:last-child) {
            margin-bottom: 1.25rem;
          }
          em {
            color: var(--color-red);
          }
        }
      }
    }
    .discord-button {
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      gap: 0.75rem;
      margin-top: 1.5rem;
      padding: 1.125rem;
      background-color: hsla(0, 0%, 0%, 0.46);
      border: 2px solid hsla(235, 86%, 65%, 0.64);
      color: var(--color-discord);
      text-decoration: none;
      width: 100%;
      max-width: 420px;
      &:hover {
        background-color: var(--color-discord);
        color: var(--color-black);
        .effect {
          animation: throb 896.5ms ease-in-out infinite;
          image-rendering: crisp-edges;
          paint-order: stroke fill;
          -webkit-text-stroke: 0.125rem var(--color-discord);
        }
      }
      .discord-icon {
        flex-shrink: 0;
      }
      .effect {
        display: inline-block;
      }
    }
  }
</style>
