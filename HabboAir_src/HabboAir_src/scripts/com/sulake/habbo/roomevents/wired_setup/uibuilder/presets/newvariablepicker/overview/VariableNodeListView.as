package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   
   public class VariableNodeListView implements IComponentInterfaceQueue
   {
      private static var MAX_HEIGHT:int = 300;
      
      private static var SCROLLBAR_WIDTH:int = 9;
      
      private var _window:UnknownICoreWindowComponents6;
      
      private var _picker:NewVariablePicker;
      
      private var _childNodes:Vector.<VariableNodeView>;
      
      private var _currentHoveredNode:VariableNodeView;
      
      private var _disposed:Boolean;
      
      public function VariableNodeListView(param1:NewVariablePicker, param2:Vector.<VariableNode>, param3:int, param4:Boolean = false)
      {
         var _loc7_:VariableNodeView = null;
         var _loc8_:int = 0;
         var _loc5_:VariableNode = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         super();
         _picker = param1;
         _window = param1.expandedView.overviewTemplate.clone() as UnknownICoreWindowComponents6;
         if(!param4)
         {
            _window.style = 12;
         }
         _childNodes = new Vector.<VariableNodeView>();
         _window.width = param3;
         if(param2 != null && param2.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < param2.length)
            {
               _loc5_ = param2[_loc8_];
               _loc7_ = new VariableNodeView(_loc5_,_picker,this,_loc8_);
               nodesList.addListItem(_loc7_.window);
               _childNodes.push(_loc7_);
               _loc8_ += 1;
            }
            _loc6_ = _childNodes[0].window.height * param2.length;
            nodesList.height = Math.min(_loc6_,MAX_HEIGHT);
            _loc9_ = param3 - scrollbarWidth;
            if(!param4)
            {
               _loc9_ -= 3;
            }
            for each(_loc7_ in _childNodes)
            {
               _loc7_.window.width = _loc9_;
               if(!param4)
               {
                  _loc7_.window.x = 1;
               }
            }
         }
         else
         {
            nodesList.height = 10;
         }
      }
      
      public function get scrollbarWidth() : int
      {
         return nodesList.isScrollBarVisible ? SCROLLBAR_WIDTH : 0;
      }
      
      public function setHover(param1:VariableNodeView) : void
      {
         if(param1 == _currentHoveredNode)
         {
            return;
         }
         if(_currentHoveredNode != null)
         {
            _currentHoveredNode.hover = false;
            _currentHoveredNode = null;
         }
         if(param1 != null)
         {
            _currentHoveredNode = param1;
            param1.hover = true;
         }
      }
      
      public function get childNodes() : Vector.<VariableNodeView>
      {
         return _childNodes;
      }
      
      public function get window() : UnknownICoreWindowComponents6
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc1_ in _childNodes)
         {
            _loc1_.dispose();
         }
         nodesList.removeListItems();
         _childNodes = null;
         _picker = null;
         _window.dispose();
         _window = null;
         _currentHoveredNode = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get nodesList() : IScrollableListWindow
      {
         return _window.findChildByName("nodes_list") as IScrollableListWindow;
      }
   }
}

