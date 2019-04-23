<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Create an account</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a></h2>
    </c:if>
  </div>
  <div>
      <form:form method="POST" modelAttribute="treeString">
          Please input your data:
          <div class="form-group ${error != null ? 'has-error' : ''}">
              <span>${message}</span>
              <input id = "inputLabelTreeString" name="treeString" type="text" class="form-control" placeholder="1,2,3,null,null,4,5"
                     autofocus="true"/>

              <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="printPathSum()">Submit tree</button>

              <input type="hidden" id="name-parameter" value="<c:out value="${param.name}"/>"/>

          </div>
      </form:form>
  </div>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
  <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
  <script type="text/javascript">

      function TreeNode(val) {
          this.val = val;
          this.left = this.right = null;
      }

      function printPathSum() {
          var treeNodeRoot = deserialize(document.getElementById('inputLabelTreeString').value);
          var sum = sumOfLongRootToLeafPathUtil(treeNodeRoot);
          if(isNaN(sum)){
              alert("Please refresh and enter a valid string.");
          } else{
              alert("Sum = " + sumOfLongRootToLeafPathUtil(treeNodeRoot)+". Please fresh and do another calculation.");
          }
      }

      var deserialize = function(data) {
          if (data === '') {
              return null;
          }
          var values = data.split(',');
          var root = new TreeNode(parseInt(values[0]));
          var queue = [root];
          for (var i=1; i < values.length; i++) {
              var parent = queue.shift();

              if (values[i] !== 'null') {
                  var left = new TreeNode(parseInt(values[i]));
                  parent.left  = left;
                  queue.push(left);
              }
              if (values[++i] !== 'null' && i !== values.length) {
                  var right = new TreeNode(parseInt(values[i]));
                  parent.right = right;
                  queue.push(right);
              }
          }
          return root;
      };

      var maxLen = 0;
      var maxSum = 0;

      // function to find the sum of nodes on the
      // longest path from root to leaf node
      var sumOfLongRootToLeafPath = function(root, sum, len) {
          // if true, then we have traversed a
          // root to leaf path
          if (root == null) {
              // update maximum length and maximum sum
              // according to the given conditions
              if (maxLen < len) {
                  maxLen = len;
                  maxSum = sum;
              } else if (maxLen == len && maxSum < sum)
                  maxSum = sum;
              return;
          }

          // recur for left subtree
          sumOfLongRootToLeafPath(root.left, sum + root.val,
              len + 1);

          sumOfLongRootToLeafPath(root.right, sum + root.val,
              len + 1);

      }

      // utility function to find the sum of nodes on
      // the longest path from root to leaf node
      var sumOfLongRootToLeafPathUtil = function(root) {
          // if tree is NULL, then sum is 0
          if (root == null)
              return 0;

          // finding the maximum sum 'maxSum' for the
          // maximum length root to leaf path
          sumOfLongRootToLeafPath(root, 0, 0);

          // required maximum sum
          return maxSum;
      }
  </script>
</body>
</html>
