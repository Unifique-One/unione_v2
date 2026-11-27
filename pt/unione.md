# PROJETO UNIONE ( UNIFIQUE CLOUD ONE )
- O FOCO É UMA PLATAFORMA UNIFICADA COM APPS DO NEXTCLOUD COMPLETA USANDO O BRANDING OFICIAL DA UNIFIQUE (https://unifique.com.br)
-----------------------------------
# EXEMPLO DO BRANDING OFICIAL, CORES E ESTILOS:
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Unifique Cloud — Workspace Corporativo</title>
  
  <!-- Tipografia Oficial: Plus Jakarta Sans + Inter (Geometria arredondada fiel ao portal unifique.com.br) -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
  
  <!-- Lucide Icons -->
  <script src="https://unpkg.com/lucide@latest"></script>

  <style>
    /*
     * UNIFIQUE CLOUD
     * Branding Oficial — Identidade Visual unifique.com.br
     * Nextcloud White-Label Theme Override
     */
    :root {
      /* Cores Institucionais Oficiais (unifique.com.br) */
      --unifique-royal: #212492;         /* Azul Royal Oficial da marca Unifique */
      --unifique-royal-dark: #161869;    /* Azul Marinho Profundo (Hover / Active) */
      --unifique-royal-light: #3539B8;   /* Azul Royal Vibrante */
      --unifique-primary: #212492;
      --unifique-primary-dark: #161869;
      --unifique-primary-light: #00AEEF;

      /* Cores de Destaque & Energia (unifique.com.br) */
      --unifique-yellow: #F5EC5A;        /* Amarelo Energia Oficial (CTAs e destaques) */
      --unifique-yellow-bright: #FFD500; /* Amarelo Vivo (Hover / Acento) */
      --unifique-cyan: #00AEEF;          /* Ciano Conectividade */
      --unifique-magenta: #E6007E;       /* Magenta */
      --unifique-green: #45B649;         /* Verde Segurança */
      --unifique-purple: #743BBD;        /* Roxo Talk/Meet */

      /* Neutros & Superfícies */
      --unifique-white: #FFFFFF;
      --unifique-black: #111111;
      --unifique-gray-50: #F6F8FC;
      --unifique-gray-100: #EEF2F9;
      --unifique-gray-200: #DCE3F0;
      --unifique-gray-300: #C2CCE0;
      --unifique-gray-500: #5E6882;
      --unifique-gray-700: #2A324B;
      --unifique-gray-900: #0F1429;

      /* Tokens Semânticos */
      --unifique-background: var(--unifique-white);
      --unifique-surface: var(--unifique-gray-50);
      --unifique-text: var(--unifique-gray-900);
      --unifique-text-muted: var(--unifique-gray-500);
      --unifique-border: var(--unifique-gray-200);

      /* Nextcloud Native Variable Overrides */
      --color-primary: var(--unifique-royal);
      --color-primary-element: var(--unifique-royal);
      --color-primary-element-hover: var(--unifique-royal-dark);
      --color-primary-element-text: var(--unifique-white);
      --color-main-background: var(--unifique-background);
      --color-background-hover: var(--unifique-gray-100);
      --color-main-text: var(--unifique-text);
      --color-text-maxcontrast: var(--unifique-text-muted);
      --color-border: var(--unifique-border);

      /* Tipografia */
      --unifique-font-display: "Plus Jakarta Sans", "Inter", sans-serif;
      --unifique-font-family: "Inter", "Plus Jakarta Sans", Arial, sans-serif;

      /* Formas & Bordas Arredondadas (Estilo unifique.com.br) */
      --unifique-radius-sm: 6px;
      --unifique-radius-md: 10px;
      --unifique-radius-lg: 16px;
      --unifique-radius-xl: 22px;
      --unifique-radius-pill: 9999px;

      /* Sombras Suaves */
      --unifique-shadow-sm: 0 2px 6px rgba(33, 36, 146, 0.06);
      --unifique-shadow-md: 0 6px 18px rgba(33, 36, 146, 0.10);
      --unifique-shadow-lg: 0 14px 36px rgba(22, 24, 105, 0.16);
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: var(--unifique-font-family);
      color: var(--unifique-text);
      background: var(--unifique-surface);
      height: 100vh;
      display: flex;
      flex-direction: column;
      overflow: hidden;
      -webkit-font-smoothing: antialiased;
    }

    /* ==========================================================================
       1. TOP HEADER BAR — ESTILO PORTAL UNIFIQUE.COM.BR
       ========================================================================== */
    .nc-header {
      height: 66px;
      background: linear-gradient(90deg, #191C7A 0%, #212492 55%, #272BA8 100%);
      color: var(--unifique-white);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 24px;
      box-shadow: var(--unifique-shadow-md);
      z-index: 50;
      flex-shrink: 0;
      border-bottom: 3px solid var(--unifique-yellow);
    }

    .header-left {
      display: flex;
      align-items: center;
      gap: 28px;
    }

    /* Logotipo Oficial Unifique (Wordmark arredondada em minúsculas + ponto circular destacado no "i") */
    .brand-logo {
      display: flex;
      align-items: center;
      gap: 10px;
      text-decoration: none;
      color: var(--unifique-white);
      cursor: pointer;
      user-select: none;
    }

    .brand-badge {
      background: var(--unifique-yellow);
      color: var(--unifique-royal-dark);
      padding: 3px 10px;
      border-radius: var(--unifique-radius-pill);
      font-family: var(--unifique-font-display);
      font-size: 11px;
      font-weight: 800;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.18);
    }

    /* Nextcloud App Switcher Navigation */
    .app-nav {
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .app-nav-item {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 8px 15px;
      border-radius: var(--unifique-radius-pill);
      color: rgba(255, 255, 255, 0.88);
      font-family: var(--unifique-font-display);
      font-size: 13.5px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s ease;
      border: 1px solid transparent;
      background: transparent;
      position: relative;
    }

    .app-nav-item:hover {
      background: rgba(255, 255, 255, 0.14);
      color: var(--unifique-white);
    }

    .app-nav-item.active {
      background: var(--unifique-white);
      color: var(--unifique-royal);
      font-weight: 700;
      box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
    }

    .app-nav-item.active i {
      color: var(--unifique-royal);
    }

    /* Header Right Controls */
    .header-right {
      display: flex;
      align-items: center;
      gap: 14px;
    }

    .global-search {
      position: relative;
      display: flex;
      align-items: center;
    }

    .global-search input {
      background: rgba(15, 18, 78, 0.55);
      border: 1px solid rgba(255, 255, 255, 0.25);
      border-radius: var(--unifique-radius-pill);
      padding: 8px 16px 8px 38px;
      color: var(--unifique-white);
      font-size: 13px;
      width: 245px;
      transition: all 0.2s ease;
      font-family: var(--unifique-font-family);
    }

    .global-search input::placeholder {
      color: rgba(255, 255, 255, 0.72);
    }

    .global-search input:focus {
      outline: none;
      background: var(--unifique-white);
      color: var(--unifique-royal-dark);
      border-color: var(--unifique-yellow);
      width: 295px;
      box-shadow: var(--unifique-shadow-md);
    }

    .global-search input:focus::placeholder {
      color: var(--unifique-text-muted);
    }

    .global-search i {
      position: absolute;
      left: 13px;
      width: 16px;
      height: 16px;
      color: var(--unifique-yellow);
      pointer-events: none;
    }

    .global-search input:focus + i {
      color: var(--unifique-royal);
    }

    .icon-btn {
      width: 38px;
      height: 38px;
      border-radius: var(--unifique-radius-pill);
      border: 1px solid rgba(255, 255, 255, 0.18);
      background: rgba(255, 255, 255, 0.08);
      color: var(--unifique-white);
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      position: relative;
      transition: all 0.2s ease;
    }

    .icon-btn:hover {
      background: var(--unifique-yellow);
      color: var(--unifique-royal-dark);
      border-color: var(--unifique-yellow);
    }

    .notif-dot {
      position: absolute;
      top: 7px;
      right: 8px;
      width: 8px;
      height: 8px;
      border-radius: 50%;
      background: var(--unifique-cyan);
      border: 2px solid var(--unifique-royal);
    }

    .user-avatar {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 4px 12px 4px 5px;
      border-radius: var(--unifique-radius-pill);
      background: rgba(255, 255, 255, 0.14);
      border: 1px solid rgba(255, 255, 255, 0.25);
      cursor: pointer;
      transition: 0.2s ease;
    }

    .user-avatar:hover {
      background: rgba(255, 255, 255, 0.24);
      border-color: var(--unifique-yellow);
    }

    .avatar-circle {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      background: var(--unifique-yellow);
      color: var(--unifique-royal-dark);
      font-family: var(--unifique-font-display);
      font-weight: 800;
      font-size: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* ==========================================================================
       2. MAIN WORKSPACE LAYOUT
       ========================================================================== */
    .workspace-container {
      display: flex;
      flex: 1;
      overflow: hidden;
    }

    /* Left Sidebar (Nextcloud Navigation Drawer) */
    .nc-sidebar {
      width: 264px;
      background: var(--unifique-white);
      border-right: 1px solid var(--unifique-border);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 18px 14px;
      flex-shrink: 0;
      overflow-y: auto;
    }

    .sidebar-group {
      display: flex;
      flex-direction: column;
      gap: 4px;
    }

    .sidebar-label {
      font-family: var(--unifique-font-display);
      font-size: 11px;
      font-weight: 800;
      text-transform: uppercase;
      letter-spacing: 0.06em;
      color: var(--unifique-royal);
      padding: 14px 12px 6px;
      opacity: 0.85;
    }

    .sidebar-link {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px 14px;
      border-radius: var(--unifique-radius-pill);
      color: var(--unifique-gray-700);
      font-size: 13.5px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.15s ease;
      border: none;
      background: transparent;
      text-align: left;
      width: 100%;
    }

    .sidebar-link-left {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .sidebar-link:hover {
      background: var(--unifique-gray-100);
      color: var(--unifique-royal);
    }

    .sidebar-link.active {
      background: var(--unifique-royal);
      color: var(--unifique-white);
      font-weight: 600;
      box-shadow: 0 3px 10px rgba(33, 36, 146, 0.22);
    }

    .sidebar-badge {
      background: var(--unifique-gray-100);
      color: var(--unifique-royal);
      font-size: 11px;
      font-weight: 700;
      padding: 2px 8px;
      border-radius: var(--unifique-radius-pill);
    }

    .sidebar-link.active .sidebar-badge {
      background: var(--unifique-yellow);
      color: var(--unifique-royal-dark);
    }

    /* Storage Quota Card in Sidebar */
    .storage-card {
      background: linear-gradient(145deg, #212492 0%, #161869 100%);
      color: var(--unifique-white);
      border-radius: var(--unifique-radius-lg);
      padding: 16px;
      margin-top: 16px;
      box-shadow: var(--unifique-shadow-md);
    }

    .storage-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      font-size: 12px;
      font-weight: 700;
      margin-bottom: 10px;
    }

    .storage-bar-bg {
      height: 8px;
      background: rgba(255, 255, 255, 0.2);
      border-radius: var(--unifique-radius-pill);
      overflow: hidden;
      margin-bottom: 9px;
    }

    .storage-bar-fill {
      height: 100%;
      width: 34%;
      background: linear-gradient(90deg, var(--unifique-cyan), var(--unifique-yellow));
      border-radius: var(--unifique-radius-pill);
    }

    .storage-meta {
      font-size: 11px;
      color: rgba(255, 255, 255, 0.82);
      display: flex;
      justify-content: space-between;
    }

    /* ==========================================================================
       3. MAIN CONTENT AREA (FILES / DASHBOARD / APPS)
       ========================================================================== */
    .nc-main {
      flex: 1;
      display: flex;
      flex-direction: column;
      background: var(--unifique-surface);
      overflow-y: auto;
    }

    /* Toolbar / Action Header */
    .content-toolbar {
      padding: 16px 28px;
      border-bottom: 1px solid var(--unifique-border);
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      background: var(--unifique-white);
      position: sticky;
      top: 0;
      z-index: 20;
    }

    .breadcrumbs {
      display: flex;
      align-items: center;
      gap: 8px;
      font-family: var(--unifique-font-display);
      font-size: 16px;
      font-weight: 700;
      color: var(--unifique-royal-dark);
    }

    .crumb-item {
      display: flex;
      align-items: center;
      gap: 6px;
      color: var(--unifique-text-muted);
      cursor: pointer;
      padding: 4px 10px;
      border-radius: var(--unifique-radius-pill);
    }

    .crumb-item:hover {
      background: var(--unifique-gray-100);
      color: var(--unifique-royal);
    }

    .crumb-item.current {
      color: var(--unifique-royal);
      font-weight: 800;
    }

    .toolbar-actions {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    /* Botões Oficiais Unifique (Pill shape + Amarelo Energia / Azul Royal) */
    .btn-primary {
      background: var(--unifique-yellow);
      color: var(--unifique-royal-dark);
      border: 1px solid var(--unifique-yellow);
      border-radius: var(--unifique-radius-pill);
      padding: 10px 20px;
      font-family: var(--unifique-font-display);
      font-weight: 800;
      font-size: 13.5px;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;
      transition: all 0.2s ease;
      box-shadow: 0 3px 10px rgba(245, 236, 90, 0.35);
    }

    .btn-primary:hover {
      background: var(--unifique-yellow-bright);
      border-color: var(--unifique-yellow-bright);
      transform: translateY(-1px);
      box-shadow: 0 5px 14px rgba(245, 236, 90, 0.5);
    }

    .btn-royal {
      background: var(--unifique-royal);
      color: var(--unifique-white);
      border: 1px solid var(--unifique-royal);
      border-radius: var(--unifique-radius-pill);
      padding: 10px 18px;
      font-family: var(--unifique-font-display);
      font-weight: 700;
      font-size: 13.5px;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .btn-royal:hover {
      background: var(--unifique-royal-dark);
    }

    .btn-secondary {
      background: var(--unifique-white);
      color: var(--unifique-royal);
      border: 1.5px solid var(--unifique-royal);
      border-radius: var(--unifique-radius-pill);
      padding: 9px 16px;
      font-family: var(--unifique-font-display);
      font-weight: 700;
      font-size: 13.5px;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;
      transition: 0.2s ease;
    }

    .btn-secondary:hover {
      background: var(--unifique-royal);
      color: var(--unifique-white);
    }

    .view-toggle {
      display: flex;
      background: var(--unifique-gray-100);
      padding: 4px;
      border-radius: var(--unifique-radius-pill);
      border: 1px solid var(--unifique-border);
    }

    .view-toggle button {
      border: none;
      background: transparent;
      padding: 6px 10px;
      border-radius: var(--unifique-radius-pill);
      color: var(--unifique-text-muted);
      cursor: pointer;
      display: flex;
      align-items: center;
    }

    .view-toggle button.active {
      background: var(--unifique-royal);
      color: var(--unifique-white);
      box-shadow: var(--unifique-shadow-sm);
    }

    /* Quick Access / Ecosystem Cards */
    .content-body {
      padding: 24px 28px;
      display: flex;
      flex-direction: column;
      gap: 24px;
    }

    .ecosystem-strip {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(225px, 1fr));
      gap: 16px;
    }

    .unifique-card {
      background: var(--unifique-white);
      border: 1px solid var(--unifique-border);
      border-radius: var(--unifique-radius-lg);
      box-shadow: var(--unifique-shadow-sm);
      padding: 18px 20px;
      transition: all 0.2s ease;
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }

    .unifique-card:hover {
      box-shadow: var(--unifique-shadow-md);
      border-color: var(--unifique-royal);
      transform: translateY(-2px);
    }

    .product-accent-drive { border-top: 4px solid var(--unifique-royal); }
    .product-accent-office { border-top: 4px solid var(--unifique-cyan); }
    .product-accent-meet { border-top: 4px solid var(--unifique-yellow-bright); }
    .product-accent-security { border-top: 4px solid var(--unifique-green); }

    .card-top {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 12px;
    }

    .card-icon {
      width: 40px;
      height: 40px;
      border-radius: var(--unifique-radius-md);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .card-title {
      font-family: var(--unifique-font-display);
      font-size: 15.5px;
      font-weight: 800;
      color: var(--unifique-royal-dark);
      margin-bottom: 4px;
    }

    .card-desc {
      font-size: 12.5px;
      color: var(--unifique-text-muted);
      line-height: 1.45;
    }

    /* ==========================================================================
       4. NEXTCLOUD FILES TABLE & GRID
       ========================================================================== */
    .files-section-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 12px;
    }

    .files-section-title {
      font-family: var(--unifique-font-display);
      font-size: 12.5px;
      font-weight: 800;
      color: var(--unifique-royal);
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    .files-table-wrapper {
      background: var(--unifique-white);
      border: 1px solid var(--unifique-border);
      border-radius: var(--unifique-radius-lg);
      overflow: hidden;
      box-shadow: var(--unifique-shadow-sm);
    }

    table.nc-files-table {
      width: 100%;
      border-collapse: collapse;
      text-align: left;
    }

    table.nc-files-table th {
      background: var(--unifique-gray-100);
      padding: 13px 18px;
      font-family: var(--unifique-font-display);
      font-size: 12px;
      font-weight: 700;
      color: var(--unifique-royal-dark);
      border-bottom: 1px solid var(--unifique-border);
      user-select: none;
    }

    table.nc-files-table td {
      padding: 13px 18px;
      font-size: 13.5px;
      border-bottom: 1px solid var(--unifique-gray-100);
      color: var(--unifique-text);
      vertical-align: middle;
    }

    table.nc-files-table tr:last-child td {
      border-bottom: none;
    }

    table.nc-files-table tbody tr {
      transition: background 0.15s ease;
      cursor: pointer;
    }

    table.nc-files-table tbody tr:hover {
      background: rgba(33, 36, 146, 0.04);
    }

    table.nc-files-table tbody tr.selected {
      background: rgba(33, 36, 146, 0.08);
    }

    .file-name-cell {
      display: flex;
      align-items: center;
      gap: 12px;
      font-weight: 600;
      color: var(--unifique-gray-900);
    }

    .file-icon-box {
      width: 36px;
      height: 36px;
      border-radius: var(--unifique-radius-md);
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }

    .tag-pill {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      padding: 4px 10px;
      border-radius: var(--unifique-radius-pill);
      font-size: 11px;
      font-weight: 700;
    }

    .tag-shared {
      background: rgba(0, 174, 239, 0.14);
      color: #0077A8;
    }

    .tag-encrypted {
      background: rgba(69, 182, 73, 0.15);
      color: #166534;
    }

    .tag-energy {
      background: var(--unifique-yellow);
      color: var(--unifique-royal-dark);
    }

    .row-actions {
      display: flex;
      align-items: center;
      justify-content: flex-end;
      gap: 6px;
    }

    .action-icon-btn {
      width: 32px;
      height: 32px;
      border-radius: var(--unifique-radius-pill);
      border: 1px solid transparent;
      background: transparent;
      color: var(--unifique-text-muted);
      display: inline-flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: 0.15s ease;
    }

    .action-icon-btn:hover {
      background: var(--unifique-white);
      border-color: var(--unifique-royal);
      color: var(--unifique-royal);
    }

    .action-icon-btn.starred {
      color: #D97706;
    }

    /* Grid View Mode */
    .files-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(215px, 1fr));
      gap: 16px;
    }

    .file-grid-card {
      background: var(--unifique-white);
      border: 1px solid var(--unifique-border);
      border-radius: var(--unifique-radius-lg);
      padding: 18px;
      display: flex;
      flex-direction: column;
      gap: 12px;
      cursor: pointer;
      transition: all 0.15s ease;
    }

    .file-grid-card:hover {
      border-color: var(--unifique-royal);
      box-shadow: var(--unifique-shadow-md);
    }

    /* ==========================================================================
       5. RIGHT DETAILS DRAWER (NEXTCLOUD FILE INSPECTOR)
       ========================================================================== */
    .nc-details-drawer {
      width: 340px;
      background: var(--unifique-white);
      border-left: 1px solid var(--unifique-border);
      display: none;
      flex-direction: column;
      padding: 22px;
      overflow-y: auto;
      flex-shrink: 0;
    }

    .nc-details-drawer.open {
      display: flex;
    }

    .drawer-header {
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      padding-bottom: 16px;
      border-bottom: 1px solid var(--unifique-border);
      margin-bottom: 16px;
    }

    .drawer-tabs {
      display: flex;
      border-bottom: 1px solid var(--unifique-border);
      margin-bottom: 16px;
      gap: 18px;
    }

    .drawer-tab {
      padding-bottom: 10px;
      font-family: var(--unifique-font-display);
      font-size: 13.5px;
      font-weight: 700;
      color: var(--unifique-text-muted);
      border-bottom: 3px solid transparent;
      cursor: pointer;
      background: none;
      border-top: none;
      border-left: none;
      border-right: none;
    }

    .drawer-tab.active {
      color: var(--unifique-royal);
      border-bottom-color: var(--unifique-yellow-bright);
    }

    .unifique-input {
      background: var(--unifique-white);
      color: var(--unifique-text);
      border: 1.5px solid var(--unifique-gray-300);
      border-radius: var(--unifique-radius-pill);
      padding: 10px 16px;
      font-size: 13.5px;
      width: 100%;
      font-family: var(--unifique-font-family);
    }

    .unifique-input:focus {
      outline: none;
      border-color: var(--unifique-royal);
      box-shadow: 0 0 0 3px rgba(33, 36, 146, 0.12);
    }

    /* ==========================================================================
       6. MODALS & TOASTS
       ========================================================================== */
    .modal-backdrop {
      position: fixed;
      inset: 0;
      background: rgba(15, 20, 41, 0.6);
      backdrop-filter: blur(4px);
      display: none;
      align-items: center;
      justify-content: center;
      z-index: 100;
      padding: 20px;
    }

    .modal-backdrop.active {
      display: flex;
    }

    .modal-box {
      background: var(--unifique-white);
      border-radius: var(--unifique-radius-xl);
      box-shadow: var(--unifique-shadow-lg);
      width: 100%;
      max-width: 470px;
      padding: 26px;
      border: 1px solid var(--unifique-border);
      animation: popIn 0.18s ease-out;
    }

    @keyframes popIn {
      from { opacity: 0; transform: scale(0.96); }
      to { opacity: 1; transform: scale(1); }
    }

    .toast-container {
      position: fixed;
      bottom: 22px;
      right: 22px;
      display: flex;
      flex-direction: column;
      gap: 10px;
      z-index: 200;
    }

    .toast {
      background: var(--unifique-royal-dark);
      color: var(--unifique-white);
      padding: 13px 18px;
      border-radius: var(--unifique-radius-pill);
      font-size: 13px;
      font-weight: 600;
      box-shadow: var(--unifique-shadow-lg);
      display: flex;
      align-items: center;
      gap: 10px;
      border: 1px solid rgba(245, 236, 90, 0.4);
    }

    @media (max-width: 900px) {
      .nc-sidebar { width: 220px; }
      .global-search input { width: 170px; }
      .app-nav span { display: none; }
    }

    @media (max-width: 680px) {
      .nc-sidebar { display: none; }
      .ecosystem-strip { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>

  <!-- ========================================================================
       HEADER BAR — IDENTIDADE OFICIAL UNIFIQUE.COM.BR
       ======================================================================== -->
  <header class="nc-header">
    <div class="header-left">
      <!-- Logotipo Oficial Unifique: tipografia arredondada em minúsculas + ponto circular separado sobre o "i" -->
      <div class="brand-logo" onclick="switchSection('all')">
        <svg width="134" height="34" viewBox="0 0 164 42" fill="none" xmlns="http://www.w3.org/2000/svg" aria-label="unifique">
          <!-- Wordmark "unifique" com 'i' sem ponto padrão para receber o círculo oficial -->
          <text x="2" y="31" fill="#FFFFFF" font-family="'Plus Jakarta Sans', 'Inter', sans-serif" font-weight="800" font-size="29" letter-spacing="-0.04em">unıfıque</text>
          <!-- Pontos circulares icônicos da marca Unifique sobre os dois "i" -->
          <circle cx="44.2" cy="8.5" r="3.2" fill="#F5EC5A"/>
          <circle cx="71.2" cy="8.5" r="3.2" fill="#00AEEF"/>
        </svg>
        <span class="brand-badge">Cloud</span>
      </div>

      <!-- Nextcloud Top App Navigation -->
      <nav class="app-nav" aria-label="Aplicativos Unifique Cloud">
        <button class="app-nav-item active" data-app="drive" onclick="selectTopApp(this, 'Unifique Drive')">
          <i data-lucide="folder-closed" style="width:17px;height:17px;"></i>
          <span>Arquivos</span>
        </button>
        <button class="app-nav-item" data-app="office" onclick="selectTopApp(this, 'Unifique Office')">
          <i data-lucide="file-spreadsheet" style="width:17px;height:17px;"></i>
          <span>Office</span>
        </button>
        <button class="app-nav-item" data-app="meet" onclick="selectTopApp(this, 'Unifique Talk & Meet')">
          <i data-lucide="video" style="width:17px;height:17px;"></i>
          <span>Talk</span>
        </button>
        <button class="app-nav-item" data-app="photos" onclick="selectTopApp(this, 'Cofre & Segurança')">
          <i data-lucide="shield-check" style="width:17px;height:17px;"></i>
          <span>Cofre</span>
        </button>
        <button class="app-nav-item" data-app="calendar" onclick="selectTopApp(this, 'Agenda Corporativa')">
          <i data-lucide="calendar" style="width:17px;height:17px;"></i>
          <span>Agenda</span>
        </button>
      </nav>
    </div>

    <div class="header-right">
      <div class="global-search">
        <input type="text" id="searchInput" placeholder="Buscar arquivos, pastas ou pessoas..." oninput="handleSearch(this.value)" />
        <i data-lucide="search"></i>
      </div>

      <button class="icon-btn" title="Notificações da Nuvem" onclick="showToast('Todas as sincronizações da Unifique Cloud estão atualizadas.')">
        <i data-lucide="bell" style="width:18px;height:18px;"></i>
        <span class="notif-dot"></span>
      </button>

      <button class="icon-btn" title="Paleta Oficial unifique.com.br" onclick="openDesignTokenModal()">
        <i data-lucide="palette" style="width:18px;height:18px;"></i>
      </button>

      <div class="user-avatar" onclick="showToast('Conectado como Rafael Mendes (corporativo@unifique.com.br)')">
        <div class="avatar-circle">RM</div>
        <span style="font-size:13px;font-weight:700;">Rafael M.</span>
        <i data-lucide="chevron-down" style="width:14px;height:14px;opacity:0.9;"></i>
      </div>
    </div>
  </header>

  <!-- ========================================================================
       MAIN WORKSPACE CONTAINER
       ======================================================================== -->
  <div class="workspace-container">
    
    <!-- LEFT SIDEBAR -->
    <aside class="nc-sidebar">
      <div>
        <div class="sidebar-group">
          <button class="sidebar-link active" id="nav-all" onclick="switchSection('all')">
            <span class="sidebar-link-left">
              <i data-lucide="hard-drive" style="width:17px;height:17px;"></i>
              Todos os arquivos
            </span>
            <span class="sidebar-badge" id="count-all">8</span>
          </button>
          <button class="sidebar-link" id="nav-recent" onclick="switchSection('recent')">
            <span class="sidebar-link-left">
              <i data-lucide="clock" style="width:17px;height:17px;"></i>
              Recentes
            </span>
          </button>
          <button class="sidebar-link" id="nav-favorites" onclick="switchSection('favorites')">
            <span class="sidebar-link-left">
              <i data-lucide="star" style="width:17px;height:17px;"></i>
              Favoritos
            </span>
            <span class="sidebar-badge" id="count-fav">3</span>
          </button>
          <button class="sidebar-link" id="nav-shared" onclick="switchSection('shared')">
            <span class="sidebar-link-left">
              <i data-lucide="users" style="width:17px;height:17px;"></i>
              Compartilhados
            </span>
            <span class="sidebar-badge" id="count-shared">4</span>
          </button>
        </div>

        <div class="sidebar-label">Pastas Corporativas</div>
        <div class="sidebar-group">
          <button class="sidebar-link" onclick="filterByTag('Engenharia')">
            <span class="sidebar-link-left">
              <span style="width:10px;height:10px;border-radius:50%;background:var(--unifique-royal);"></span>
              Infraestrutura & Rede
            </span>
          </button>
          <button class="sidebar-link" onclick="filterByTag('Comercial')">
            <span class="sidebar-link-left">
              <span style="width:10px;height:10px;border-radius:50%;background:var(--unifique-cyan);"></span>
              Comercial B2B
            </span>
          </button>
          <button class="sidebar-link" onclick="filterByTag('Segurança')">
            <span class="sidebar-link-left">
              <span style="width:10px;height:10px;border-radius:50%;background:var(--unifique-green);"></span>
              Compliance & LGPD
            </span>
          </button>
        </div>

        <div class="sidebar-label">Sistema</div>
        <div class="sidebar-group">
          <button class="sidebar-link" id="nav-trash" onclick="switchSection('trash')">
            <span class="sidebar-link-left">
              <i data-lucide="trash-2" style="width:17px;height:17px;"></i>
              Arquivos excluídos
            </span>
          </button>
        </div>
      </div>

      <!-- Storage Quota Indicator -->
      <div class="storage-card">
        <div class="storage-header">
          <span>Nuvem Unifique</span>
          <span style="color:var(--unifique-yellow);">34% usado</span>
        </div>
        <div class="storage-bar-bg">
          <div class="storage-bar-fill"></div>
        </div>
        <div class="storage-meta">
          <span>340 GB de 1 TB</span>
          <span>Datacenter SC</span>
        </div>
      </div>
    </aside>

    <!-- MAIN CONTENT PANEL -->
    <main class="nc-main">
      <!-- Toolbar -->
      <div class="content-toolbar">
        <div class="breadcrumbs" id="breadcrumbs">
          <span class="crumb-item" onclick="switchSection('all')">
            <i data-lucide="home" style="width:16px;height:16px;color:var(--unifique-royal);"></i>
          </span>
          <span style="color:var(--unifique-gray-300);">/</span>
          <span class="crumb-item current" id="currentSectionTitle">Todos os arquivos</span>
        </div>

        <div class="toolbar-actions">
          <div class="view-toggle" title="Alternar visualização">
            <button id="btnViewList" class="active" onclick="setViewMode('list')">
              <i data-lucide="list" style="width:16px;height:16px;"></i>
            </button>
            <button id="btnViewGrid" onclick="setViewMode('grid')">
              <i data-lucide="layout-grid" style="width:16px;height:16px;"></i>
            </button>
          </div>

          <button class="btn-secondary" onclick="openNewFolderModal()">
            <i data-lucide="folder-plus" style="width:16px;height:16px;"></i>
            Nova Pasta
          </button>

          <button class="btn-primary" onclick="triggerSimulatedUpload()">
            <i data-lucide="upload-cloud" style="width:17px;height:17px;"></i>
            Enviar Arquivo
          </button>
        </div>
      </div>

      <!-- Body -->
      <div class="content-body">
        
        <!-- Ecosystem Product Strip (Cores Oficiais unifique.com.br) -->
        <section class="ecosystem-strip" aria-label="Suíte Unifique Cloud">
          <div class="unifique-card product-accent-drive" onclick="switchSection('all')">
            <div class="card-top">
              <div class="card-icon" style="background:rgba(33,36,146,0.1);color:var(--unifique-royal);">
                <i data-lucide="cloud" style="width:20px;height:20px;"></i>
              </div>
              <span class="tag-pill tag-shared">Ativo</span>
            </div>
            <div class="card-title">Unifique Drive</div>
            <div class="card-desc">Sincronização corporativa em alta velocidade nos Datacenters Unifique.</div>
          </div>

          <div class="unifique-card product-accent-office" onclick="createQuickDoc()">
            <div class="card-top">
              <div class="card-icon" style="background:rgba(0,174,239,0.14);color:var(--unifique-cyan);">
                <i data-lucide="file-text" style="width:20px;height:20px;"></i>
              </div>
              <span class="tag-pill tag-energy">+ Criar Doc</span>
            </div>
            <div class="card-title">Unifique Office</div>
            <div class="card-desc">Edição colaborativa em tempo real de documentos, planilhas e slides.</div>
          </div>

          <div class="unifique-card product-accent-meet" onclick="showToast('Sala Unifique Talk iniciada: meet.unifique.com.br/corporativo')">
            <div class="card-top">
              <div class="card-icon" style="background:rgba(245,236,90,0.45);color:var(--unifique-royal-dark);">
                <i data-lucide="video" style="width:20px;height:20px;"></i>
              </div>
              <span class="tag-pill" style="background:rgba(33,36,146,0.1);color:var(--unifique-royal);">HD • E2EE</span>
            </div>
            <div class="card-title">Unifique Talk</div>
            <div class="card-desc">Videoconferências e chat corporativo integrados aos seus arquivos.</div>
          </div>

          <div class="unifique-card product-accent-security" onclick="filterByTag('Segurança')">
            <div class="card-top">
              <div class="card-icon" style="background:rgba(69,182,73,0.14);color:var(--unifique-green);">
                <i data-lucide="lock" style="width:20px;height:20px;"></i>
              </div>
              <span class="tag-pill tag-encrypted">ISO 27001</span>
            </div>
            <div class="card-title">Cofre & Segurança</div>
            <div class="card-desc">Criptografia ponta a ponta, auditoria LGPD e backup redundante.</div>
          </div>
        </section>

        <!-- Files Section -->
        <section>
          <div class="files-section-header">
            <span class="files-section-title" id="listHeaderLabel">Diretório Raiz • 8 itens</span>
            <span style="font-size:12px;color:var(--unifique-text-muted);">Clique em um item para inspecionar ou compartilhar</span>
          </div>

          <!-- Table View -->
          <div class="files-table-wrapper" id="tableViewContainer">
            <table class="nc-files-table">
              <thead>
                <tr>
                  <th style="width:44%;">Nome</th>
                  <th style="width:18%;">Status / Departamento</th>
                  <th style="width:12%;">Tamanho</th>
                  <th style="width:16%;">Modificado</th>
                  <th style="width:10%;text-align:right;">Ações</th>
                </tr>
              </thead>
              <tbody id="filesTableBody">
                <!-- Populated by JS -->
              </tbody>
            </table>
          </div>

          <!-- Grid View -->
          <div class="files-grid" id="gridViewContainer" style="display:none;">
            <!-- Populated by JS -->
          </div>
        </section>

      </div>
    </main>

    <!-- RIGHT DETAILS & SHARE DRAWER -->
    <aside class="nc-details-drawer" id="detailsDrawer">
      <div class="drawer-header">
        <div style="display:flex;align-items:center;gap:12px;">
          <div id="drawerIconBox" class="file-icon-box" style="background:rgba(33,36,146,0.1);color:var(--unifique-royal);">
            <i data-lucide="folder"></i>
          </div>
          <div>
            <h3 id="drawerFileName" style="font-family:var(--unifique-font-display);font-size:15px;font-weight:800;color:var(--unifique-royal-dark);word-break:break-word;">Nome do Arquivo</h3>
            <span id="drawerFileMeta" style="font-size:12px;color:var(--unifique-text-muted);">Pasta • 120 MB</span>
          </div>
        </div>
        <button class="action-icon-btn" onclick="closeDrawer()" title="Fechar painel">
          <i data-lucide="x" style="width:18px;height:18px;"></i>
        </button>
      </div>

      <div class="drawer-tabs">
        <button class="drawer-tab active" onclick="switchDrawerTab('share', this)">Compartilhar</button>
        <button class="drawer-tab" onclick="switchDrawerTab('activity', this)">Atividade</button>
      </div>

      <!-- Tab: Share -->
      <div id="tab-share" style="display:flex;flex-direction:column;gap:16px;">
        <div>
          <label style="display:block;font-size:12px;font-weight:700;color:var(--unifique-royal-dark);margin-bottom:6px;">
            Convidar equipe Unifique
          </label>
          <div style="display:flex;gap:8px;">
            <input type="text" id="shareEmailInput" class="unifique-input" placeholder="nome@unifique.com.br" />
            <button class="btn-royal" style="padding:8px 14px;" onclick="addCollaborator()">
              <i data-lucide="send" style="width:15px;height:15px;"></i>
            </button>
          </div>
        </div>

        <div style="background:var(--unifique-gray-50);border:1px solid var(--unifique-border);border-radius:var(--unifique-radius-lg);padding:14px;">
          <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:8px;">
            <span style="font-size:13px;font-weight:700;color:var(--unifique-royal-dark);display:flex;align-items:center;gap:6px;">
              <i data-lucide="link" style="width:15px;height:15px;color:var(--unifique-royal);"></i>
              Link público seguro
            </span>
            <button class="btn-primary" style="padding:5px 12px;font-size:12px;" onclick="copyShareLink()">
              Copiar Link
            </button>
          </div>
          <p style="font-size:11.5px;color:var(--unifique-text-muted);">
            Protegido por SSL Unifique Cloud. Qualquer pessoa com o link pode visualizar.
          </p>
        </div>

        <div>
          <span style="display:block;font-size:12px;font-weight:700;color:var(--unifique-royal-dark);margin-bottom:8px;">
            Pessoas com acesso
          </span>
          <div id="collaboratorsList" style="display:flex;flex-direction:column;gap:8px;">
            <!-- Populated by JS -->
          </div>
        </div>
      </div>

      <!-- Tab: Activity -->
      <div id="tab-activity" style="display:none;flex-direction:column;gap:12px;">
        <div style="font-size:12px;padding:12px;background:var(--unifique-gray-50);border-radius:var(--unifique-radius-md);border-left:4px solid var(--unifique-royal);">
          <strong>Rafael Mendes</strong> atualizou este item<br/>
          <span style="color:var(--unifique-text-muted);font-size:11px;">Hoje às 14:22 • IP Corporativo</span>
        </div>
        <div style="font-size:12px;padding:12px;background:var(--unifique-gray-50);border-radius:var(--unifique-radius-md);border-left:4px solid var(--unifique-green);">
          <strong>Verificação Antivírus & DLP</strong> concluída<br/>
          <span style="color:var(--unifique-text-muted);font-size:11px;">Nenhuma ameaça detectada</span>
        </div>
      </div>
    </aside>
  </div>

  <!-- ========================================================================
       MODAL: NOVA PASTA
       ======================================================================== -->
  <div class="modal-backdrop" id="newFolderModal">
    <div class="modal-box">
      <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
        <h3 style="font-family:var(--unifique-font-display);font-size:18px;font-weight:800;color:var(--unifique-royal-dark);">Criar Nova Pasta</h3>
        <button class="action-icon-btn" onclick="closeModal('newFolderModal')">
          <i data-lucide="x" style="width:18px;height:18px;"></i>
        </button>
      </div>
      <p style="font-size:13px;color:var(--unifique-text-muted);margin-bottom:14px;">
        A pasta será sincronizada automaticamente com todos os seus dispositivos conectados à Unifique Cloud.
      </p>
      <input type="text" id="newFolderNameInput" class="unifique-input" placeholder="Ex: Projetos Fibra 2026" style="margin-bottom:18px;" />
      <div style="display:flex;justify-content:flex-end;gap:10px;">
        <button class="btn-secondary" onclick="closeModal('newFolderModal')">Cancelar</button>
        <button class="btn-primary" onclick="confirmCreateFolder()">Criar Pasta</button>
      </div>
    </div>
  </div>

  <!-- ========================================================================
       MODAL: BRANDING OFICIAL UNIFIQUE.COM.BR
       ======================================================================== -->
  <div class="modal-backdrop" id="designTokenModal">
    <div class="modal-box" style="max-width:520px;">
      <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:14px;">
        <h3 style="font-family:var(--unifique-font-display);font-size:18px;font-weight:800;color:var(--unifique-royal);">Branding Oficial — unifique.com.br</h3>
        <button class="action-icon-btn" onclick="closeModal('designTokenModal')">
          <i data-lucide="x" style="width:18px;height:18px;"></i>
        </button>
      </div>
      <p style="font-size:13px;color:var(--unifique-text-muted);margin-bottom:16px;">
        Paleta institucional e estilo visual fiel ao portal oficial da Unifique:
      </p>
      <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-bottom:18px;">
        <div style="padding:12px;border-radius:12px;background:#212492;color:#fff;font-size:11px;font-weight:700;">Azul Royal Oficial<br/>#212492</div>
        <div style="padding:12px;border-radius:12px;background:#161869;color:#fff;font-size:11px;font-weight:700;">Azul Marinho<br/>#161869</div>
        <div style="padding:12px;border-radius:12px;background:#F5EC5A;color:#161869;font-size:11px;font-weight:800;">Amarelo Energia<br/>#F5EC5A</div>
        <div style="padding:12px;border-radius:12px;background:#00AEEF;color:#fff;font-size:11px;font-weight:700;">Ciano Conectividade<br/>#00AEEF</div>
        <div style="padding:12px;border-radius:12px;background:#45B649;color:#fff;font-size:11px;font-weight:700;">Verde Segurança<br/>#45B649</div>
        <div style="padding:12px;border-radius:12px;background:#E6007E;color:#fff;font-size:11px;font-weight:700;">Magenta<br/>#E6007E</div>
      </div>
      <div style="display:flex;justify-content:flex-end;">
        <button class="btn-primary" onclick="closeModal('designTokenModal')">Concluído</button>
      </div>
    </div>
  </div>

  <!-- Toast Container -->
  <div class="toast-container" id="toastContainer"></div>

  <!-- ========================================================================
       APPLICATION LOGIC
       ======================================================================== -->
  <script>
    // Initial Nextcloud File Repository State
    let filesData = [
      {
        id: 1,
        name: "Infraestrutura & Backbone SC",
        type: "folder",
        category: "Engenharia",
        size: "1.4 GB",
        modified: "Hoje, 11:20",
        starred: true,
        shared: true,
        encrypted: false,
        trash: false,
        collaborators: ["Ana Paula (Engenharia)", "Carlos Silva (NOC)"]
      },
      {
        id: 2,
        name: "Propostas Corporativas B2B 2026",
        type: "folder",
        category: "Comercial",
        size: "680 MB",
        modified: "Ontem, 17:45",
        starred: true,
        shared: true,
        encrypted: false,
        trash: false,
        collaborators: ["Mariana Costa (Vendas)"]
      },
      {
        id: 3,
        name: "Políticas LGPD & Auditoria ISO 27001",
        type: "folder",
        category: "Segurança",
        size: "412 MB",
        modified: "22 Nov 2026",
        starred: false,
        shared: false,
        encrypted: true,
        trash: false,
        collaborators: ["DPO Unifique"]
      },
      {
        id: 4,
        name: "Apresentação_Institucional_Unifique_Cloud.pptx",
        type: "slides",
        category: "Comercial",
        size: "18.4 MB",
        modified: "Hoje, 09:15",
        starred: true,
        shared: true,
        encrypted: false,
        trash: false,
        collaborators: ["Marketing Unifique", "Diretoria"]
      },
      {
        id: 5,
        name: "SLA_Datacenter_Brusque_TierIII.pdf",
        type: "pdf",
        category: "Segurança",
        size: "4.2 MB",
        modified: "24 Nov 2026",
        starred: false,
        shared: true,
        encrypted: true,
        trash: false,
        collaborators: ["Operações DC"]
      },
      {
        id: 6,
        name: "Planejamento_Expansao_Fibra_Sul.xlsx",
        type: "sheet",
        category: "Engenharia",
        size: "6.8 MB",
        modified: "20 Nov 2026",
        starred: false,
        shared: false,
        encrypted: false,
        trash: false,
        collaborators: []
      },
      {
        id: 7,
        name: "Manual_Identidade_Visual_Unifique.pdf",
        type: "pdf",
        category: "Comercial",
        size: "24.1 MB",
        modified: "15 Nov 2026",
        starred: false,
        shared: false,
        encrypted: false,
        trash: false,
        collaborators: []
      },
      {
        id: 8,
        name: "Rascunho_Arquitetura_Nextcloud.docx",
        type: "doc",
        category: "Engenharia",
        size: "1.9 MB",
        modified: "12 Nov 2026",
        starred: false,
        shared: false,
        encrypted: false,
        trash: false,
        collaborators: []
      }
    ];

    let currentSection = "all";
    let currentTagFilter = null;
    let searchQuery = "";
    let viewMode = "list";
    let selectedFileId = null;

    // Get Icon & Official Unifique Color Token by File Type
    function getFileVisuals(type) {
      switch (type) {
        case "folder":
          return { icon: "folder", bg: "rgba(33, 36, 146, 0.12)", color: "#212492" };
        case "sheet":
          return { icon: "file-spreadsheet", bg: "rgba(69, 182, 73, 0.14)", color: "#45B649" };
        case "slides":
          return { icon: "presentation", bg: "rgba(245, 236, 90, 0.45)", color: "#161869" };
        case "pdf":
          return { icon: "file-text", bg: "rgba(230, 0, 126, 0.12)", color: "#E6007E" };
        default:
          return { icon: "file-code", bg: "rgba(0, 174, 239, 0.15)", color: "#0088C2" };
      }
    }

    // Filter files based on active state
    function getFilteredFiles() {
      return filesData.filter(file => {
        if (currentSection === "trash") {
          if (!file.trash) return false;
        } else {
          if (file.trash) return false;
        }

        if (currentSection === "favorites" && !file.starred) return false;
        if (currentSection === "shared" && !file.shared) return false;
        if (currentSection === "recent" && !file.modified.includes("Hoje") && !file.modified.includes("Ontem")) return false;
        if (currentTagFilter && file.category !== currentTagFilter) return false;

        if (searchQuery.trim() !== "") {
          const q = searchQuery.toLowerCase();
          return file.name.toLowerCase().includes(q) || file.category.toLowerCase().includes(q);
        }
        return true;
      });
    }

    // Render Files in Table or Grid
    function renderFiles() {
      const filtered = getFilteredFiles();
      const tbody = document.getElementById("filesTableBody");
      const gridContainer = document.getElementById("gridViewContainer");
      const headerLabel = document.getElementById("listHeaderLabel");

      // Update sidebar counters
      document.getElementById("count-all").textContent = filesData.filter(f => !f.trash).length;
      document.getElementById("count-fav").textContent = filesData.filter(f => !f.trash && f.starred).length;
      document.getElementById("count-shared").textContent = filesData.filter(f => !f.trash && f.shared).length;

      headerLabel.textContent = `${document.getElementById("currentSectionTitle").textContent} • ${filtered.length} ${filtered.length === 1 ? "item" : "itens"}`;

      if (filtered.length === 0) {
        const emptyHTML = `
          <tr>
            <td colspan="5" style="text-align:center;padding:42px 20px;color:var(--unifique-text-muted);">
              <i data-lucide="folder-open" style="width:36px;height:36px;margin-bottom:8px;opacity:0.5;color:var(--unifique-royal);"></i>
              <div style="font-weight:700;color:var(--unifique-royal-dark);">Nenhum arquivo encontrado nesta visualização</div>
              <div style="font-size:12px;margin-top:4px;">Tente limpar os filtros ou envie um novo arquivo para a nuvem.</div>
            </td>
          </tr>
        `;
        tbody.innerHTML = emptyHTML;
        gridContainer.innerHTML = `<div style="grid-column:1/-1;text-align:center;padding:40px;color:var(--unifique-text-muted);">Nenhum item encontrado.</div>`;
        lucide.createIcons();
        return;
      }

      // Render Table Rows
      tbody.innerHTML = filtered.map(file => {
        const vis = getFileVisuals(file.type);
        const isSelected = file.id === selectedFileId ? "selected" : "";
        let badgeHTML = `<span class="tag-pill" style="background:var(--unifique-gray-100);color:var(--unifique-royal-dark);">${file.category}</span>`;
        if (file.encrypted) {
          badgeHTML += ` <span class="tag-pill tag-encrypted"><i data-lucide="shield" style="width:11px;height:11px;"></i> Cofre</span>`;
        } else if (file.shared) {
          badgeHTML += ` <span class="tag-pill tag-shared"><i data-lucide="users" style="width:11px;height:11px;"></i> Compartilhado</span>`;
        }

        return `
          <tr class="${isSelected}" onclick="openFileInspector(${file.id})">
            <td>
              <div class="file-name-cell">
                <div class="file-icon-box" style="background:${vis.bg};color:${vis.color};">
                  <i data-lucide="${vis.icon}" style="width:18px;height:18px;"></i>
                </div>
                <span>${file.name}</span>
              </div>
            </td>
            <td>${badgeHTML}</td>
            <td style="color:var(--unifique-text-muted);font-weight:500;">${file.size}</td>
            <td style="color:var(--unifique-text-muted);">${file.modified}</td>
            <td>
              <div class="row-actions" onclick="event.stopPropagation()">
                <button class="action-icon-btn ${file.starred ? "starred" : ""}" title="Favoritar" onclick="toggleStar(${file.id})">
                  <i data-lucide="star" style="width:16px;height:16px;${file.starred ? "fill:#D97706;" : ""}"></i>
                </button>
                <button class="action-icon-btn" title="Compartilhar" onclick="openFileInspector(${file.id})">
                  <i data-lucide="share-2" style="width:16px;height:16px;"></i>
                </button>
                <button class="action-icon-btn" title="${file.trash ? "Restaurar" : "Mover para lixeira"}" onclick="toggleTrash(${file.id})">
                  <i data-lucide="${file.trash ? "rotate-ccw" : "trash-2"}" style="width:16px;height:16px;"></i>
                </button>
              </div>
            </td>
          </tr>
        `;
      }).join("");

      // Render Grid Cards
      gridContainer.innerHTML = filtered.map(file => {
        const vis = getFileVisuals(file.type);
        return `
          <div class="file-grid-card" onclick="openFileInspector(${file.id})">
            <div style="display:flex;align-items:center;justify-content:space-between;">
              <div class="file-icon-box" style="width:44px;height:44px;background:${vis.bg};color:${vis.color};">
                <i data-lucide="${vis.icon}" style="width:22px;height:22px;"></i>
              </div>
              <button class="action-icon-btn ${file.starred ? "starred" : ""}" onclick="event.stopPropagation();toggleStar(${file.id})">
                <i data-lucide="star" style="width:16px;height:16px;${file.starred ? "fill:#D97706;" : ""}"></i>
              </button>
            </div>
            <div>
              <div style="font-size:14px;font-weight:700;color:var(--unifique-royal-dark);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" title="${file.name}">
                ${file.name}
              </div>
              <div style="font-size:12px;color:var(--unifique-text-muted);margin-top:4px;">
                ${file.size} • ${file.category}
              </div>
            </div>
          </div>
        `;
      }).join("");

      lucide.createIcons();
    }

    // Navigation & Filtering
    function switchSection(section) {
      currentSection = section;
      currentTagFilter = null;

      document.querySelectorAll(".sidebar-link").forEach(el => el.classList.remove("active"));
      const navBtn = document.getElementById(`nav-${section}`);
      if (navBtn) navBtn.classList.add("active");

      const titles = {
        all: "Todos os arquivos",
        recent: "Arquivos recentes",
        favorites: "Favoritos",
        shared: "Compartilhados comigo",
        trash: "Arquivos excluídos"
      };
      document.getElementById("currentSectionTitle").textContent = titles[section] || "Todos os arquivos";
      renderFiles();
    }

    function filterByTag(tag) {
      currentSection = "all";
      currentTagFilter = tag;
      document.querySelectorAll(".sidebar-link").forEach(el => el.classList.remove("active"));
      document.getElementById("currentSectionTitle").textContent = `Departamento: ${tag}`;
      renderFiles();
    }

    function handleSearch(val) {
      searchQuery = val;
      renderFiles();
    }

    function setViewMode(mode) {
      viewMode = mode;
      document.getElementById("btnViewList").classList.toggle("active", mode === "list");
      document.getElementById("btnViewGrid").classList.toggle("active", mode === "grid");
      document.getElementById("tableViewContainer").style.display = mode === "list" ? "block" : "none";
      document.getElementById("gridViewContainer").style.display = mode === "grid" ? "grid" : "none";
    }

    function selectTopApp(btn, appName) {
      document.querySelectorAll(".app-nav-item").forEach(el => el.classList.remove("active"));
      btn.classList.add("active");
      showToast(`Módulo ${appName} ativo`);
    }

    // File Actions
    function toggleStar(id) {
      const file = filesData.find(f => f.id === id);
      if (!file) return;
      file.starred = !file.starred;
      showToast(file.starred ? `"${file.name}" adicionado aos favoritos` : `"${file.name}" removido dos favoritos`);
      renderFiles();
    }

    function toggleTrash(id) {
      const file = filesData.find(f => f.id === id);
      if (!file) return;
      file.trash = !file.trash;
      if (selectedFileId === id) closeDrawer();
      showToast(file.trash ? `"${file.name}" movido para a lixeira` : `"${file.name}" restaurado`);
      renderFiles();
    }

    // Inspector Drawer
    function openFileInspector(id) {
      const file = filesData.find(f => f.id === id);
      if (!file) return;
      selectedFileId = id;
      const vis = getFileVisuals(file.type);

      const iconBox = document.getElementById("drawerIconBox");
      iconBox.style.background = vis.bg;
      iconBox.style.color = vis.color;
      iconBox.innerHTML = `<i data-lucide="${vis.icon}"></i>`;

      document.getElementById("drawerFileName").textContent = file.name;
      document.getElementById("drawerFileMeta").textContent = `${file.category} • ${file.size} • ${file.modified}`;

      renderCollaborators(file);
      document.getElementById("detailsDrawer").classList.add("open");
      renderFiles();
      lucide.createIcons();
    }

    function closeDrawer() {
      selectedFileId = null;
      document.getElementById("detailsDrawer").classList.remove("open");
      renderFiles();
    }

    function switchDrawerTab(tab, btn) {
      document.querySelectorAll(".drawer-tab").forEach(el => el.classList.remove("active"));
      btn.classList.add("active");
      document.getElementById("tab-share").style.display = tab === "share" ? "flex" : "none";
      document.getElementById("tab-activity").style.display = tab === "activity" ? "flex" : "none";
    }

    function renderCollaborators(file) {
      const list = document.getElementById("collaboratorsList");
      if (!file.collaborators || file.collaborators.length === 0) {
        list.innerHTML = `<div style="font-size:12px;color:var(--unifique-text-muted);">Apenas você tem acesso a este item.</div>`;
        return;
      }
      list.innerHTML = file.collaborators.map(person => `
        <div style="display:flex;align-items:center;justify-content:space-between;padding:8px 12px;background:var(--unifique-gray-50);border-radius:var(--unifique-radius-pill);font-size:12px;">
          <span style="font-weight:600;color:var(--unifique-royal-dark);">${person}</span>
          <span style="color:var(--unifique-royal);font-weight:700;">Editor</span>
        </div>
      `).join("");
    }

    function addCollaborator() {
      const input = document.getElementById("shareEmailInput");
      const val = input.value.trim();
      if (!val || !selectedFileId) return;

      const file = filesData.find(f => f.id === selectedFileId);
      file.collaborators.push(val);
      file.shared = true;
      input.value = "";
      renderCollaborators(file);
      renderFiles();
      showToast(`Compartilhado com ${val}`);
    }

    function copyShareLink() {
      const fakeUrl = `https://cloud.unifique.com.br/s/${Math.random().toString(36).substring(2, 10)}`;
      if (navigator.clipboard) {
        navigator.clipboard.writeText(fakeUrl).catch(() => {});
      }
      showToast(`Link copiado: ${fakeUrl}`);
    }

    // Modals & Creation
    function openNewFolderModal() {
      document.getElementById("newFolderNameInput").value = "";
      document.getElementById("newFolderModal").classList.add("active");
      setTimeout(() => document.getElementById("newFolderNameInput").focus(), 50);
    }

    function openDesignTokenModal() {
      document.getElementById("designTokenModal").classList.add("active");
    }

    function closeModal(id) {
      document.getElementById(id).classList.remove("active");
    }

    function confirmCreateFolder() {
      const name = document.getElementById("newFolderNameInput").value.trim();
      if (!name) return;
      filesData.unshift({
        id: Date.now(),
        name,
        type: "folder",
        category: "Engenharia",
        size: "0 KB",
        modified: "Agora mesmo",
        starred: false,
        shared: false,
        encrypted: false,
        trash: false,
        collaborators: []
      });
      closeModal("newFolderModal");
      switchSection("all");
      showToast(`Pasta "${name}" criada na Unifique Cloud`);
    }

    function triggerSimulatedUpload() {
      const sampleNames = [
        "Topologia_Rede_FTTH_2026.pdf",
        "Relatorio_Disponibilidade_Cloud.xlsx",
        "Contrato_Corporativo_Unifique.docx"
      ];
      const randomName = sampleNames[Math.floor(Math.random() * sampleNames.length)];
      const ext = randomName.endsWith(".xlsx") ? "sheet" : randomName.endsWith(".pdf") ? "pdf" : "doc";

      filesData.unshift({
        id: Date.now(),
        name: randomName,
        type: ext,
        category: "Comercial",
        size: "3.4 MB",
        modified: "Agora mesmo",
        starred: false,
        shared: false,
        encrypted: true,
        trash: false,
        collaborators: []
      });
      switchSection("all");
      showToast(`Upload concluído: "${randomName}"`);
    }

    function createQuickDoc() {
      const docName = `Documento_Unifique_${new Date().getHours()}h${new Date().getMinutes()}.docx`;
      filesData.unshift({
        id: Date.now(),
        name: docName,
        type: "doc",
        category: "Comercial",
        size: "24 KB",
        modified: "Agora mesmo",
        starred: true,
        shared: false,
        encrypted: false,
        trash: false,
        collaborators: []
      });
      switchSection("all");
      showToast(`Documento "${docName}" criado no Unifique Office`);
    }

    // Custom Toast Notification System
    function showToast(message) {
      const container = document.getElementById("toastContainer");
      const toast = document.createElement("div");
      toast.className = "toast";
      toast.innerHTML = `<i data-lucide="check-circle-2" style="width:17px;height:17px;color:#F5EC5A;flex-shrink:0;"></i><span>${message}</span>`;
      container.appendChild(toast);
      lucide.createIcons();

      setTimeout(() => {
        toast.style.opacity = "0";
        toast.style.transform = "translateY(8px)";
        toast.style.transition = "0.2s ease";
        setTimeout(() => toast.remove(), 220);
      }, 3400);
    }

    // Boot
    document.addEventListener("DOMContentLoaded", () => {
      renderFiles();
    });
  </script>
</body>
</html>
