<?php
function e(string $value): string { return htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); }
function money(float $amount): string { return 'ZMW ' . number_format($amount, 2); }
function set_notice(string $message): void { $_SESSION['notice'] = $message; }
function redirect(string $url): never { header('Location: ' . $url); exit; }
function csrf_field(): string {
    if (empty($_SESSION['csrf_token'])) $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    return '<input type="hidden" name="csrf_token" value="' . e($_SESSION['csrf_token']) . '">';
}
function verify_csrf(): void {
    $sent = $_POST['csrf_token'] ?? '';
    if (!is_string($sent) || empty($_SESSION['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $sent)) {
        http_response_code(419); exit('Invalid form token. Refresh and try again.');
    }
}
function stock_badge(int $quantity, int $reorder): string {
    if ($quantity === 0) return '<span class="badge out">Out of stock</span>';
    if ($quantity <= $reorder) return '<span class="badge low">Low stock</span>';
    return '<span class="badge in">In stock</span>';
}
