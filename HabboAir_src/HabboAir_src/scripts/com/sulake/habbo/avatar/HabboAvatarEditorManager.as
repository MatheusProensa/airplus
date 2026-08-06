package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.habbo.avatar.enum.UnknownHabboAvatarEnum1;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.*;
   import flash.events.Event;
   
   public class HabboAvatarEditorManager extends Component implements IHabboAvatarEditorManager, ILinkEventTracker
   {
      public static const UnknownConstFromHabboAvatarEditorManager_Uint_1:uint = 1;
      
      public static const UnknownConstFromHabboAvatarEditorManager_Uint_2:uint = 2;
      
      public static const UnknownConstFromHabboAvatarEditorManager_Uint_3:uint = 3;
      
      private static const GENERIC:String = "generic";
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _inventory:IHabboInventory;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _sessionData:ISessionDataManager;
      
      private var _roomUI:IRoomUI;
      
      private var _handler:AvatarEditorMessageHandler;
      
      private var _editors:Map;
      
      public function HabboAvatarEditorManager(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _editors = new Map();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDCoreWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         },(flags & 3) == 0),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },true,[{
            "type":"AVATAR_RENDER_READY",
            "callback":onAvatarRendererReady
         }]),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         },(flags & 1) == 0,[]),new ComponentDependency(new IIDCoreLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },(flags & 2) == 0),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionData = param1;
         }),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false)]);
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         if(_communication)
         {
            _handler = new AvatarEditorMessageHandler(this,_communication);
         }
      }
      
      override public function dispose() : void
      {
         if(_editors)
         {
            for each(var _loc1_ in _editors)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            _editors = null;
         }
         if(_handler != null)
         {
            _handler.dispose();
            _handler = null;
         }
         super.dispose();
      }
      
      public function openEditor(param1:uint, param2:UnknownIHabboAvatar2, param3:Array = null, param4:Boolean = false, param5:String = null, param6:String = "generic") : IFrameController
      {
         var _loc7_:HabboAvatarEditor = _editors.getValue(param1);
         if(!_loc7_)
         {
            _loc7_ = new HabboAvatarEditor(param1,this);
            _editors.add(param1,_loc7_);
         }
         return _loc7_.openWindow(param2,param3,param4,param5,param6);
      }
      
      public function embedEditorToContext(param1:uint, param2:IWindowController_1, param3:UnknownIHabboAvatar2 = null, param4:Array = null, param5:Boolean = false, param6:Boolean = false) : Boolean
      {
         var _loc7_:HabboAvatarEditor = _editors.getValue(param1);
         if(_loc7_)
         {
            _loc7_.dispose();
         }
         _loc7_ = new HabboAvatarEditor(param1,this,param6);
         _editors.add(param1,_loc7_);
         _loc7_.embedToContext(param2,param3,param4,param5);
         return true;
      }
      
      public function loadAvatarInEditor(param1:uint, param2:String, param3:String, param4:int = 0) : void
      {
         var _loc5_:HabboAvatarEditor = _editors.getValue(param1) as HabboAvatarEditor;
         if(_loc5_)
         {
            return _loc5_.loadAvatarInEditor(param2,param3,param4);
         }
      }
      
      public function loadOwnAvatarInEditor(param1:uint) : void
      {
         var _loc2_:HabboAvatarEditor = _editors.getValue(param1) as HabboAvatarEditor;
         if(_loc2_)
         {
            if(_loc2_.hasNftOutfit())
            {
               return _loc2_.loadFallbackFigure();
            }
            return _loc2_.loadAvatarInEditor(sessionData.figure,sessionData.gender,sessionData.clubLevel);
         }
      }
      
      public function close(param1:uint) : void
      {
         if(!_editors)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = _editors.getValue(param1) as HabboAvatarEditor;
         if(!_loc2_)
         {
            return;
         }
         if(!UnknownHabboAvatarEnum1.isDevelopmentEditor(param1))
         {
            _loc2_.figureData.avatarEffectType = inventory.getLastActivatedEffect();
         }
         switch(int(param1))
         {
            case 0:
               _loc2_.hide();
               break;
            case 1:
               _loc2_.hide();
               _loc2_.dispose();
               _editors.remove(param1);
               break;
            case 2:
               break;
            default:
               _loc2_.hide();
               _windowManager.LilithCustomsInstance.DevWarIsOpen = false;
         }
      }
      
      public function getEditor(param1:uint) : HabboAvatarEditor
      {
         return _editors.getValue(param1) as HabboAvatarEditor;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      private function onAvatarRendererReady(param1:Event = null) : void
      {
         this.events.dispatchEvent(new Event("AVATAR_EDITOR_READY"));
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get handler() : AvatarEditorMessageHandler
      {
         return _handler;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionData;
      }
      
      public function get inventory() : IHabboInventory
      {
         return _inventory;
      }
      
      public function get roomDesktop() : IRoomDesktop
      {
         return _roomUI.desktop;
      }
      
      public function get linkPattern() : String
      {
         return "avatareditor/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("open" === _loc3_)
         {
            openEditor(0,null,null,true);
            loadOwnAvatarInEditor(0);
         }
      }
   }
}

