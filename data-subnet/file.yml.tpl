${vpc_chunk}

vpc:
  id: "${vpc_id}"
  cidr: "${vpc_cidr}"
  subnets:
    private:
      ${subnets}
