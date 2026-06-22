local LSP = require('automa.kit.LSP')
local AsyncTask = require('automa.kit.Async.AsyncTask')

---@class automa.kit.LSP.Client
---@field public client vim.lsp.Client
local Client = {}
Client.__index = Client

---Create LSP Client wrapper.
---@param client vim.lsp.Client
---@return automa.kit.LSP.Client
function Client.new(client)
  local self = setmetatable({}, Client)
  self.client = client
  return self
end

---Send request.
---@param method string
---@param params table
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:request(method, params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request(method, params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ImplementationParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_implementation(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/implementation', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.TypeDefinitionParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_typeDefinition(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/typeDefinition', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_workspaceFolders(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/workspaceFolders', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ConfigurationParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_configuration(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/configuration', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentColorParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentColor(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentColor', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ColorPresentationParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_colorPresentation(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/colorPresentation', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.FoldingRangeParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_foldingRange(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/foldingRange', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_foldingRange_refresh(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/foldingRange/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DeclarationParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_declaration(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/declaration', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.SelectionRangeParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_selectionRange(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/selectionRange', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.WorkDoneProgressCreateParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:window_workDoneProgress_create(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('window/workDoneProgress/create', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CallHierarchyPrepareParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_prepareCallHierarchy(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/prepareCallHierarchy', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CallHierarchyIncomingCallsParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:callHierarchy_incomingCalls(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('callHierarchy/incomingCalls', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CallHierarchyOutgoingCallsParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:callHierarchy_outgoingCalls(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('callHierarchy/outgoingCalls', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.SemanticTokensParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_semanticTokens_full(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/semanticTokens/full', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.SemanticTokensDeltaParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_semanticTokens_full_delta(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/semanticTokens/full/delta', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.SemanticTokensRangeParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_semanticTokens_range(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/semanticTokens/range', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_semanticTokens_refresh(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/semanticTokens/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ShowDocumentParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:window_showDocument(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('window/showDocument', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.LinkedEditingRangeParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_linkedEditingRange(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/linkedEditingRange', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CreateFilesParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_willCreateFiles(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/willCreateFiles', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.RenameFilesParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_willRenameFiles(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/willRenameFiles', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DeleteFilesParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_willDeleteFiles(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/willDeleteFiles', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.MonikerParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_moniker(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/moniker', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.TypeHierarchyPrepareParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_prepareTypeHierarchy(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/prepareTypeHierarchy', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.TypeHierarchySupertypesParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:typeHierarchy_supertypes(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('typeHierarchy/supertypes', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.TypeHierarchySubtypesParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:typeHierarchy_subtypes(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('typeHierarchy/subtypes', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.InlineValueParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_inlineValue(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/inlineValue', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_inlineValue_refresh(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/inlineValue/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.InlayHintParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_inlayHint(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/inlayHint', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.InlayHint
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:inlayHint_resolve(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('inlayHint/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_inlayHint_refresh(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/inlayHint/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentDiagnosticParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_diagnostic(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/diagnostic', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.WorkspaceDiagnosticParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_diagnostic(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/diagnostic', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_diagnostic_refresh(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/diagnostic/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.InlineCompletionParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_inlineCompletion(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/inlineCompletion', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.TextDocumentContentParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_textDocumentContent(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/textDocumentContent', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.TextDocumentContentRefreshParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_textDocumentContent_refresh(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/textDocumentContent/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.RegistrationParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:client_registerCapability(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('client/registerCapability', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.UnregistrationParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:client_unregisterCapability(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('client/unregisterCapability', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.InitializeParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:initialize(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('initialize', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:shutdown(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('shutdown', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ShowMessageRequestParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:window_showMessageRequest(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('window/showMessageRequest', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.WillSaveTextDocumentParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_willSaveWaitUntil(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/willSaveWaitUntil', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CompletionParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_completion(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/completion', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CompletionItem
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:completionItem_resolve(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('completionItem/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.HoverParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_hover(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/hover', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.SignatureHelpParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_signatureHelp(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/signatureHelp', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DefinitionParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_definition(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/definition', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ReferenceParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_references(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/references', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentHighlightParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentHighlight(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentHighlight', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentSymbolParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentSymbol(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentSymbol', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CodeActionParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_codeAction(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/codeAction', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CodeAction
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:codeAction_resolve(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('codeAction/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.WorkspaceSymbolParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_symbol(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/symbol', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.WorkspaceSymbol
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspaceSymbol_resolve(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspaceSymbol/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CodeLensParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_codeLens(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/codeLens', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.CodeLens
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:codeLens_resolve(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('codeLens/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_codeLens_refresh(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/codeLens/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentLinkParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentLink(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentLink', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentLink
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:documentLink_resolve(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('documentLink/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentFormattingParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_formatting(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/formatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentRangeFormattingParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_rangeFormatting(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/rangeFormatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentRangesFormattingParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_rangesFormatting(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/rangesFormatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.DocumentOnTypeFormattingParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_onTypeFormatting(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/onTypeFormatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.RenameParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_rename(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/rename', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.PrepareRenameParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_prepareRename(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/prepareRename', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ExecuteCommandParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_executeCommand(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/executeCommand', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---@param params automa.kit.LSP.ApplyWorkspaceEditParams
---@return automa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_applyEdit(params)
  local _, request_id, reject_ ---@type any, integer?, fun(err: any?)
  ---@type automa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/applyEdit', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    if request_id then
      self.client:cancel_request(request_id)
    end
    reject_(LSP.LSPErrorCodes.RequestCancelled)
  end
  return task
end

---Send notification.
---@param method string
---@param params table
function Client:notify(method, params)
  self.client:notify(method, params)
end

---@param params automa.kit.LSP.DidChangeWorkspaceFoldersParams
function Client:workspace_didChangeWorkspaceFolders(params)
  self.client:notify('workspace/didChangeWorkspaceFolders', params)
end

---@param params automa.kit.LSP.WorkDoneProgressCancelParams
function Client:window_workDoneProgress_cancel(params)
  self.client:notify('window/workDoneProgress/cancel', params)
end

---@param params automa.kit.LSP.CreateFilesParams
function Client:workspace_didCreateFiles(params)
  self.client:notify('workspace/didCreateFiles', params)
end

---@param params automa.kit.LSP.RenameFilesParams
function Client:workspace_didRenameFiles(params)
  self.client:notify('workspace/didRenameFiles', params)
end

---@param params automa.kit.LSP.DeleteFilesParams
function Client:workspace_didDeleteFiles(params)
  self.client:notify('workspace/didDeleteFiles', params)
end

---@param params automa.kit.LSP.DidOpenNotebookDocumentParams
function Client:notebookDocument_didOpen(params)
  self.client:notify('notebookDocument/didOpen', params)
end

---@param params automa.kit.LSP.DidChangeNotebookDocumentParams
function Client:notebookDocument_didChange(params)
  self.client:notify('notebookDocument/didChange', params)
end

---@param params automa.kit.LSP.DidSaveNotebookDocumentParams
function Client:notebookDocument_didSave(params)
  self.client:notify('notebookDocument/didSave', params)
end

---@param params automa.kit.LSP.DidCloseNotebookDocumentParams
function Client:notebookDocument_didClose(params)
  self.client:notify('notebookDocument/didClose', params)
end

---@param params automa.kit.LSP.InitializedParams
function Client:initialized(params)
  self.client:notify('initialized', params)
end

---@param params nil
function Client:exit(params)
  self.client:notify('exit', params)
end

---@param params automa.kit.LSP.DidChangeConfigurationParams
function Client:workspace_didChangeConfiguration(params)
  self.client:notify('workspace/didChangeConfiguration', params)
end

---@param params automa.kit.LSP.ShowMessageParams
function Client:window_showMessage(params)
  self.client:notify('window/showMessage', params)
end

---@param params automa.kit.LSP.LogMessageParams
function Client:window_logMessage(params)
  self.client:notify('window/logMessage', params)
end

---@param params automa.kit.LSP.LSPAny
function Client:telemetry_event(params)
  self.client:notify('telemetry/event', params)
end

---@param params automa.kit.LSP.DidOpenTextDocumentParams
function Client:textDocument_didOpen(params)
  self.client:notify('textDocument/didOpen', params)
end

---@param params automa.kit.LSP.DidChangeTextDocumentParams
function Client:textDocument_didChange(params)
  self.client:notify('textDocument/didChange', params)
end

---@param params automa.kit.LSP.DidCloseTextDocumentParams
function Client:textDocument_didClose(params)
  self.client:notify('textDocument/didClose', params)
end

---@param params automa.kit.LSP.DidSaveTextDocumentParams
function Client:textDocument_didSave(params)
  self.client:notify('textDocument/didSave', params)
end

---@param params automa.kit.LSP.WillSaveTextDocumentParams
function Client:textDocument_willSave(params)
  self.client:notify('textDocument/willSave', params)
end

---@param params automa.kit.LSP.DidChangeWatchedFilesParams
function Client:workspace_didChangeWatchedFiles(params)
  self.client:notify('workspace/didChangeWatchedFiles', params)
end

---@param params automa.kit.LSP.PublishDiagnosticsParams
function Client:textDocument_publishDiagnostics(params)
  self.client:notify('textDocument/publishDiagnostics', params)
end

---@param params automa.kit.LSP.SetTraceParams
function Client:dollar_setTrace(params)
  self.client:notify('$/setTrace', params)
end

---@param params automa.kit.LSP.LogTraceParams
function Client:dollar_logTrace(params)
  self.client:notify('$/logTrace', params)
end

---@param params automa.kit.LSP.CancelParams
function Client:dollar_cancelRequest(params)
  self.client:notify('$/cancelRequest', params)
end

---@param params automa.kit.LSP.ProgressParams
function Client:dollar_progress(params)
  self.client:notify('$/progress', params)
end

return Client
