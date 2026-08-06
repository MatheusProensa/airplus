package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   
   public class VariableNode
   {
      private var _variable:WiredVariable;
      
      private var _children:Map;
      
      private var _name:String;
      
      public function VariableNode(param1:WiredVariable, param2:String)
      {
         super();
         _variable = param1;
         _name = param2;
         _children = new Map();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get variable() : WiredVariable
      {
         return _variable;
      }
      
      public function get children() : Vector.<VariableNode>
      {
         return Vector.<VariableNode>(_children.getValues());
      }
      
      public function get childrenCount() : int
      {
         return _children.length;
      }
      
      public function getChildNodeByName(param1:String) : VariableNode
      {
         return _children.getValue(param1);
      }
      
      public function addChildNode(param1:VariableNode) : void
      {
         _children.add(param1.name,param1);
      }
      
      public function flatten(param1:Boolean = false) : Boolean
      {
         var _loc3_:VariableNode = null;
         if(_children.length == 1 && _variable == null)
         {
            _loc3_ = _children.getValues()[0];
            if(_loc3_.flatten())
            {
               _variable = _loc3_.variable;
               _children = new Map();
            }
         }
         var _loc2_:Boolean = _variable != null && _children.length == 0;
         if(param1 && _loc2_)
         {
            _name = _variable.variableName;
         }
         return _loc2_;
      }
      
      public function canBeSelected(param1:NewVariablePicker) : Boolean
      {
         if(_variable == null)
         {
            return false;
         }
         if(param1.variableFilter != null && !param1.variableFilter(variable))
         {
            return false;
         }
         return true;
      }
      
      public function isDisabled(param1:NewVariablePicker) : Boolean
      {
         if(canBeSelected(param1))
         {
            return false;
         }
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(!_loc2_.isDisabled(param1))
               {
                  return false;
               }
            }
         }
         return true;
      }
   }
}

