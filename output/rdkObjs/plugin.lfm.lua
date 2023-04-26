require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_NOME_AQUI()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", rawget(obj, "setNodeObject"));

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setFormType("tablesDock");
    obj:setDataType("DATA_TYPE_AQUI");
    obj:setTitle("TITULO_AQUI");
    obj:setName("NOME_AQUI");

    obj.button1 = GUI.fromHandle(_obj_newObject("button"));
    obj.button1:setParent(obj);
    obj.button1:setText("Teste");
    obj.button1:setName("button1");


    function teste()
        require("ndb.lua");   
        SceneLib.registerPlugin(function(scene, attachment)

            local selectedToken = scene.items.selection[1]     

            showMessage((selectedToken.ownerUserID))
        
        end);
    end

    


    obj._e_event0 = obj.button1:addEventListener("onClick",
        function (_)
            teste()
        end, obj);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.button1 ~= nil then self.button1:destroy(); self.button1 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newNOME_AQUI()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_NOME_AQUI();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _NOME_AQUI = {
    newEditor = newNOME_AQUI, 
    new = newNOME_AQUI, 
    name = "NOME_AQUI", 
    dataType = "DATA_TYPE_AQUI", 
    formType = "tablesDock", 
    formComponentName = "form", 
    title = "TITULO_AQUI", 
    description=""};

NOME_AQUI = _NOME_AQUI;
Firecast.registrarForm(_NOME_AQUI);
Firecast.registrarDataType(_NOME_AQUI);
Firecast.registrarSpecialForm(_NOME_AQUI);

return _NOME_AQUI;
