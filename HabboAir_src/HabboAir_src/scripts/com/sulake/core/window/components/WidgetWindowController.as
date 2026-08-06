package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_2;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.UnknownICoreWindow1;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class WidgetWindowController extends WindowController implements IWidgetWindowController
   {
      private var UnknownVarFromWidgetWindowController_UnknownICoreWindow1_1:UnknownICoreWindow1;
      
      private var UnknownVarFromWidgetWindowController_String_1:String = "";
      
      private var _widget:IWindowController_2;
      
      public function WidgetWindowController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         UnknownVarFromWidgetWindowController_UnknownICoreWindow1_1 = param5.getWidgetFactory();
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(_widget != null)
            {
               _widget.dispose();
               _widget = null;
            }
            UnknownVarFromWidgetWindowController_UnknownICoreWindow1_1 = null;
            super.dispose();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = _widget != null ? _widget.properties : [];
         _loc1_.unshift(createProperty("widget_type",UnknownVarFromWidgetWindowController_String_1));
         return super.properties.concat(_loc1_);
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc3_:String = null;
         for each(var _loc2_ in param1)
         {
            if(_loc2_.key == "widget_type")
            {
               _loc3_ = String(_loc2_.value);
               if(UnknownVarFromWidgetWindowController_String_1 != _loc3_)
               {
                  if(_widget != null)
                  {
                     removeChildAt(0);
                     _widget.dispose();
                  }
                  _widget = UnknownVarFromWidgetWindowController_UnknownICoreWindow1_1.createWidget(String(_loc2_.value),this);
                  UnknownVarFromWidgetWindowController_String_1 = _loc3_;
               }
               break;
            }
         }
         if(_widget != null)
         {
            _widget.properties = param1;
         }
         super.properties = param1;
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         var _loc2_:Array = [];
         groupChildrenWithTag("_COLORIZE",_loc2_,-1);
         for each(var _loc3_ in _loc2_)
         {
            _loc3_.color = param1;
         }
      }
      
      public function get iterator() : IIterator
      {
         return _widget != null ? _widget.iterator : EmptyIterator.INSTANCE;
      }
      
      public function get widget() : IWindowController_2
      {
         return _widget;
      }
      
      public function get rootWindow() : IWindowModel
      {
         return getChildAt(0);
      }
      
      public function set rootWindow(param1:IWindowModel) : void
      {
         removeChildAt(0);
         if(param1 == null)
         {
            return;
         }
         addChild(param1);
         if(param1.tags.indexOf("_EXCLUDE") < 0)
         {
            param1.tags.push("_EXCLUDE");
         }
      }
   }
}

