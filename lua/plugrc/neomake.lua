--When writing a buffer (no delay).
vim.fn['neomake#configure#automake']('nw',750)

-- Neomake C configurations
vim.g.neomake_c_uses_stdin = 1
vim.g.neomake_c_enabled_makers =  {'cppcheck'}
vim.g.neomake_c_cppcheck_maker = {
      exe ='cppcheck',
      args={'--enable=warning,style,performance,portability,information,missingInclude',
          '--inconclusive','--force','-j 4','--template=gcc','--language=c'},
}

-- Neomake C++ configurations
vim.g.neomake_cpp_uses_stdin = 1
vim.g.neomake_cpp_enabled_makers = {'cppcheck'}
vim.g.neomake_cpp_cppcheck_maker = {
      exe ='cppcheck',
      args={'--enable=warning,style,performance,portability,information,missingInclude',
          '--inconclusive','--force','-j 4','--template=gcc','--language=c++'},
}
