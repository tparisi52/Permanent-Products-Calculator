% Code retrieved from:
% https://www.mathworks.com/matlabcentral/fileexchange/63388-the-permanent-of-any-matrix-square-or-not
% on June 8, 2023

function P = permanent(A)
  % permanent - compute the matrix permanent of A. A need not be square
  % usage: P = permanent(A)
  %
  %  https://www.google.com/url?q=https://en.wikipedia.org/wiki/Computing_the_permanent&source=gmail-imap&ust=1677448312000000&usg=AOvVaw1U8pzj7Kr3FaxkTw4Noqgg
  %
  %  Think of the permanent as something like a determinant, but the
  %  terms are not added and subtracted as in the determinant.
  %
  % arguments: (input)
  %  A - matrix (usually squares) but it need not be so.
  %      Because the computations of the permanent are extremely
  %      intensive, this code will be terribly slow for large
  %      matrices. Large here is roughly larger than 10x10. This
  %      is true even though a non-recursive algorithm is employed.
  %
  %      In the case of a non-square matrix A, all terms are summed.
  %
  % arguments: (output)
  %  P - permanent of the matrix A.
  %
  % Example:
  %   A = magic(3);
  %   permanent(A)
  %   ans =
  %     900
  %
  % Example:
  %  A = ones(5);
  %  permanent(A)
  %  ans =
  %     120
  %
  % Example:
  %  A = tril(ones(5),1);
  %  permanent(A)
  %  ans =
  %      16
  %  
  % Example:
  %  A = reshape(1:6,2,3)
  %  permanent(A)
  %  ans =
  %      64
  %
  % Author: John D'Errico
  % E-mail: woodchips@rochester.rr.com
  % Date: 6/19/2017
  
  if isempty(A)
    P = [];
    return
  end
  
  % A shape
  [N,M] = size(A);
  
  % The simple case is where A is square. But if A is non-square, 
  % make sure it has more columns than rows. transpose won't impact the
  % permanent.
  if N > M
    A = A.';
    [N,M] = deal(M,N);
  end
  
  % special case, N == 1
  if N == 1
    P = sum(A);
    return
  end
   
  % if we drop through to here, then A is at least 2x2. That is,
  % we know that A now has more columns than rows. And since we
  % know that A has more than 2 rows, at least 2x2 is a given.
  
  % assume the non-square case. But if A is square, the computation
  % will be simple enough. While not a recursive method, all combinations
  % are explicitly generated using perms. This will be memory intensive
  % for N larger than 10.
  if N == M
    cols = 1:N;
  else
    cols = nchoosek(1:M,N);
  end
  cN = perms(1:N);
  
  P = 0;
  for i = 1:size(cols,1)
    P_i = A(cN(:,1),cols(i,1));
    
    for j = 2:N
      P_i = P_i .* A(cN(:,j),cols(i,j));
    end
    
    P = P + sum(P_i);
  end