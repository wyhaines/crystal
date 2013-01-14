require "program"
require "visitor"
require "ast"
require "type_inference/ast_node"

module Crystal
  def infer_type(node, options = {})
    mod = Crystal::Program.new
    if node
      node.accept TypeVisitor.new(mod)
    end
    mod
  end

  class TypeVisitor < Visitor
    attr_reader :mod

    def initialize(mod)
      @mod = mod
    end

    def visit(node : BoolLiteral)
      node.type = mod.bool
    end

    def visit(node : IntLiteral)
      node.type = mod.int
    end

    def visit(node : LongLiteral)
      node.type = mod.long
    end

    def visit(node : FloatLiteral)
      node.type = mod.float
    end

    def visit(node : DoubleLiteral)
      node.type = mod.double
    end

    def visit(node : CharLiteral)
      node.type = mod.char
    end

    def visit(node : SymbolLiteral)
      node.type = mod.symbol
    end

    def end_visit(node : Expressions)
      node.bind_to node.last unless node.empty?
    end
  end
end