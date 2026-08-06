package com.sulake.habbo.roomevents.wired_menu.tabs.common
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class VariableTypePicker implements IComponentInterfaceQueue, IProfiler_1
   {
      private static var SELECTION_TYPES:* = ["furni","user","global","context"];
      
      private var _disposed:Boolean = false;
      
      private var _container:IWindowController_1;
      
      private var _onSelectCallback:Function;
      
      private var _selected:String;
      
      private var _selectedType:int;
      
      public function VariableTypePicker(param1:IWindowController_1, param2:Function)
      {
         var _loc3_:InteractiveController = null;
         super();
         _container = param1;
         _onSelectCallback = param2;
         setMode(SELECTION_TYPES[0],true);
         for each(var _loc4_ in SELECTION_TYPES)
         {
            _loc3_ = InteractiveController(getButton(_loc4_));
            if(_loc3_ != null)
            {
               _loc3_.addEventListener("WME_OUT",maybeCancelEvent);
               _loc3_.addEventListener("WME_UP",maybeCancelEvent);
            }
         }
      }
      
      private function maybeCancelEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:UnknownICoreWindowComponents4 = param1.target as UnknownICoreWindowComponents4;
         if(_loc2_ != null)
         {
            if(param1.type == "WME_OUT" && _loc2_.id == _selectedType)
            {
               param1.preventWindowOperation();
            }
            if(param1.type == "WME_UP")
            {
               setMode(getButtonTypeName(_loc2_));
               param1.preventWindowOperation();
            }
         }
      }
      
      private function getButtonTypeName(param1:UnknownICoreWindowComponents4) : String
      {
         return param1.name.split("_")[1];
      }
      
      private function setMode(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:InteractiveController = null;
         _selected = param1;
         for each(var _loc4_ in SELECTION_TYPES)
         {
            _loc3_ = InteractiveController(getButton(_loc4_));
            if(_loc3_ != null)
            {
               if(_selected != _loc4_)
               {
                  _loc3_.state &= ~0x10;
                  _loc3_.state &= ~4;
               }
            }
         }
         _loc3_ = InteractiveController(getButton(_selected));
         if(_loc3_.id != _selectedType)
         {
            _selectedType = _loc3_.id;
            if(!param2)
            {
               _onSelectCallback(_selectedType);
            }
         }
      }
      
      public function get selectedType() : int
      {
         return _selectedType;
      }
      
      public function set selectedType(param1:int) : void
      {
         var _loc2_:UnknownICoreWindowComponents4 = null;
         for each(var _loc3_ in SELECTION_TYPES)
         {
            _loc2_ = getButton(_loc3_);
            if(_loc2_ != null)
            {
               if(_loc2_.id == param1)
               {
                  setMode(getButtonTypeName(_loc2_),true);
               }
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:InteractiveController = null;
         if(_container)
         {
            for each(var _loc3_ in SELECTION_TYPES)
            {
               _loc2_ = InteractiveController(getButton(_loc3_));
               if(_loc2_ != null)
               {
                  if(_selected == _loc3_ && (_loc2_.state & 0x10) == 0)
                  {
                     _loc2_.state |= 16;
                  }
               }
            }
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _container = null;
         _onSelectCallback = null;
         _selected = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function getButton(param1:String) : UnknownICoreWindowComponents4
      {
         return _container.findChildByName("type_" + param1 + "_button") as UnknownICoreWindowComponents4;
      }
   }
}

