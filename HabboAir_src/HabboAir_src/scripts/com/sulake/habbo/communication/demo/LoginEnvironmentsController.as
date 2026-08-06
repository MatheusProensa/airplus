package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.IWindowContext_2;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_2;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.CommunicationUtils;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   
   [SecureSWF(rename="true")]
   public class LoginEnvironmentsController extends EventDispatcherWrapper
   {
      public static const ENVIRONMENT_SELECTED_EVENT:String = "ENVIRONMENT_SELECTED_EVENT";
      
      private var UnknownVarFromLoginEnvironmentsController_IComponent_1_1:IComponent_1;
      
      private var _windowManager:IWindowContext_2;
      
      private var UnknownVarFromLoginEnvironmentsController_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromLoginEnvironmentsController_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromLoginEnvironmentsController_Int_1:int;
      
      private var UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1:IDropBaseController_2;
      
      private var _selectedEnvironment:String;
      
      public function LoginEnvironmentsController(param1:IDropBaseController_2, param2:IComponent_1, param3:IWindowContext_2, param4:IAssetLibraryCollection)
      {
         super();
         UnknownVarFromLoginEnvironmentsController_IComponent_1_1 = param2;
         _windowManager = param3;
         UnknownVarFromLoginEnvironmentsController_IAssetLibraryCollection_1 = param4;
         UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1 = param1;
         init();
      }
      
      public function get selectedEnvironment() : String
      {
         return _selectedEnvironment;
      }
      
      override public function dispose() : void
      {
         UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1 = null;
         super.dispose();
      }
      
      private function getAvailableEnvironments() : Array
      {
         return UnknownVarFromLoginEnvironmentsController_IComponent_1_1.getProperty("live.environment.list").split("/");
      }
      
      private function createListItem(param1:String) : IWindowModel
      {
         var _loc2_:XmlAsset = UnknownVarFromLoginEnvironmentsController_IAssetLibraryCollection_1.getAssetByName(param1) as XmlAsset;
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function init() : void
      {
         var _loc5_:int = 0;
         var _loc6_:IWindowController_1 = null;
         UnknownVarFromLoginEnvironmentsController_IWindowModel_1 = createListItem("login_environment_list_item");
         var _loc3_:Array = getAvailableEnvironments();
         var _loc1_:String = CommunicationUtils.readSOLString("environment");
         _loc1_ = _loc1_ == null ? "d63" : _loc1_;
         var _loc4_:Array = getEnvironmentNames(_loc3_);
         _selectedEnvironment = _loc1_;
         var _loc7_:int = UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.numMenuItems;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.removeMenuItemAt(0);
            _loc5_++;
         }
         for each(var _loc2_ in _loc4_)
         {
            _loc6_ = UnknownVarFromLoginEnvironmentsController_IWindowModel_1.clone() as IWindowController_1;
            _loc6_.findChildByName("title").caption = _loc2_;
            UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.addMenuItem(_loc6_);
         }
         UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.selection = _loc3_.indexOf(_loc1_);
         UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.procedure = dropMenuEventHandler;
         UnknownVarFromLoginEnvironmentsController_Int_1 = -1;
         testEnvironmentAvailable(false);
      }
      
      private function testEnvironmentAvailable(param1:Boolean) : void
      {
         var environmentIds:Array;
         var window:IWindowController_1;
         var environment:String;
         var host:String;
         var ports:Array;
         var socket:Socket;
         var lastEnvironmentConnected:Boolean = param1;
         if(_disposed || UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1 == null || Boolean(UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.disposed))
         {
            return;
         }
         environmentIds = getAvailableEnvironments();
         if(UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1 && UnknownVarFromLoginEnvironmentsController_Int_1 > -1 && UnknownVarFromLoginEnvironmentsController_Int_1 < UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.numMenuItems)
         {
            window = UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.getMenuItemAt(UnknownVarFromLoginEnvironmentsController_Int_1) as IWindowController_1;
            (window.findChildByName("icon") as IStaticBitmapWrapperWindow).assetUri = lastEnvironmentConnected ? "help_accept_icon" : "help_decline_icon";
         }
         UnknownVarFromLoginEnvironmentsController_Int_1++;
         if(UnknownVarFromLoginEnvironmentsController_Int_1 >= environmentIds.length)
         {
            return;
         }
         environment = environmentIds[UnknownVarFromLoginEnvironmentsController_Int_1];
         host = UnknownVarFromLoginEnvironmentsController_IComponent_1_1.getProperty("connection.info.host." + environment);
         ports = UnknownVarFromLoginEnvironmentsController_IComponent_1_1.getProperty("connection.info.port." + environment).split(",");
         socket = new Socket();
         socket.addEventListener("connect",function(param1:Event):void
         {
            (param1.target as Socket).close();
            testEnvironmentAvailable(true);
         });
         socket.addEventListener("complete",function(param1:Event):void
         {
            (param1.target as Socket).close();
         });
         socket.addEventListener("close",function(param1:Event):void
         {
            (param1.target as Socket).close();
         });
         socket.addEventListener("socketData",function(param1:ProgressEvent):void
         {
            (param1.target as Socket).close();
         });
         socket.addEventListener("securityError",function(param1:SecurityErrorEvent):void
         {
            (param1.target as Socket).close();
            testEnvironmentAvailable(false);
         });
         socket.addEventListener("ioError",function(param1:IOErrorEvent):void
         {
            (param1.target as Socket).close();
            testEnvironmentAvailable(false);
         });
         socket.connect(host,ports[0]);
      }
      
      private function getEnvironmentNames(param1:Array) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(getEnvironmentName(_loc2_));
         }
         return _loc3_;
      }
      
      public function getEnvironmentName(param1:String) : String
      {
         var _loc3_:* = param1;
         var _loc2_:String = "connection.info.name." + param1;
         if(UnknownVarFromLoginEnvironmentsController_IComponent_1_1.propertyExists(_loc2_))
         {
            _loc3_ = UnknownVarFromLoginEnvironmentsController_IComponent_1_1.getProperty(_loc2_);
         }
         else
         {
            Logger.log("Could not find name for environment: " + param1);
         }
         return _loc3_;
      }
      
      private function dropMenuEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc4_:Array = getAvailableEnvironments();
         var _loc5_:int = UnknownVarFromLoginEnvironmentsController_IDropBaseController_2_1.selection;
         var _loc3_:String = _loc4_[_loc5_];
         _selectedEnvironment = _loc3_;
         dispatchEvent(new Event("ENVIRONMENT_SELECTED_EVENT"));
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
   }
}

