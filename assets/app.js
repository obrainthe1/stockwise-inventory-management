document.addEventListener('DOMContentLoaded', () => {
  const search = document.getElementById('tableSearch');
  const table = document.getElementById('dataTable');
  if (search && table) search.addEventListener('input', () => {
    const query = search.value.toLowerCase().trim();
    table.querySelectorAll('tbody tr').forEach(row => { row.hidden = !row.textContent.toLowerCase().includes(query); });
  });
});
